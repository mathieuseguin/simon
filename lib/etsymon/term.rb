module Etsymon

  ##
  # Fun happens here!
  # Add tokens or full sentences using add_tokens or add_sentence respectively then retrieve the top n terms

  class Term
    attr_reader :tokens

    # (de)activate the indexation of ecommerce-related words
    @@activate_ecommerce_stop_words = false

    @@tokenizer = Tokenizer::WhitespaceTokenizer.new
    @@html_entities = HTMLEntities.new


    def initialize
      @tokens = {}
    end


    ##
    # Add a whole sentence to the dictionary by splitting it into tokens

    def add_sentence(sentence)
      tokens = self.class.extract_tokens(sentence)
      add_tokens(tokens) if tokens.any?
    end


    ##
    # Add tokens to the dictionary

    def add_tokens(tokens)
      tokens -= self.class.stop_words

      tokens.each do |w|
        @tokens[w] = @tokens.fetch(w, 0).to_i + 1
      end
    end


    ##
    # Get the top n terms from the dictionary
    #

    def top(count)
      @tokens.sort_by{ |_key, value| value * -1 }.first(count)
    end

    class << self
      def activate_ecommerce_stop_words
        @@activate_ecommerce_stop_words
      end

      def activate_ecommerce_stop_words=(val)
        @@activate_ecommerce_stop_words ||= val
      end

      ##
      # Convert a sentence into an array of tokens

      def extract_tokens(sentence)
        text = @@html_entities.decode(sentence)

        # remove urls
        text.gsub!(/http(?:s)?:\/\/[\w\.:\/]+/, '')

        # replace multiple-length spaces by one space
        text.gsub!(/\s+/, ' ')

        # remove non alpha-numerical characters
        text.gsub!(/[^A-Za-z0-9\s]/i, '')

        # remove words smaller than 3 characters
        text.gsub!(/\b+[\w]{1,2}\b+/i, '')

        text.downcase!
        text.strip!

        @@tokenizer.tokenize(text).map(&:singularize)
      end

      def stop_words
        if @stop_words.nil?
          common_dict = File.dirname(__FILE__) + '/../dict/common.txt'
          etsy_dict = File.dirname(__FILE__) + '/../dict/etsy.txt'

          @stop_words = File.readlines(common_dict).map(&:chomp!)
          @stop_words += File.readlines(etsy_dict).map(&:chomp!) if activate_ecommerce_stop_words
        end

        @stop_words
      end
    end
  end
end
