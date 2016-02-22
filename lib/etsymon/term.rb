module Etsymon

  ##
  # Fun happens here!
  # Add words or full sentences using add_words or add_sentence respectively then retrieve the top n terms

  class Term
    attr_reader :words

    # (de)activate the indexation of ecommerce-related words
    @@activate_ecommerce_stop_words = false

    STOP_WORDS = File.readlines(File.dirname(__FILE__) + '/../dict/common.txt').map(&:chomp!)
    STOP_WORDS_ECOMMERCE = File.readlines(File.dirname(__FILE__) + '/../dict/etsy.txt').map(&:chomp!)

    @@tokenizer = Tokenizer::WhitespaceTokenizer.new
    @@html_entities = HTMLEntities.new


    def initialize
      @words = {}
    end


    ##
    # Add a whole sentence to the dictionary by splitting it into tokens

    def add_sentence(sentence)
      tokens = self.class.extract_tokens(sentence)
      add_words(tokens) if tokens.any?
    end


    ##
    # Add words to the dictionary

    def add_words(words)
      words -= STOP_WORDS
      words -= STOP_WORDS_ECOMMERCE if self.class.activate_ecommerce_stop_words

      words.each do |w|
        @words[w] = @words.fetch(w, 0).to_i + 1
      end
    end


    ##
    # Get the top n terms from the dictionary
    #

    def top(count)
      @words.sort_by{ |_key, value| value * -1 }.first(count)
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

        # replace multiple-length spaces by one space
        text.gsub!(/\s+/, ' ')

        # remove non alpha-numerical characters
        text.gsub!(/[^A-Za-z0-9\s]/i, '')

        # remove words smaller than 3 characters
        text.gsub!(/\b+[\w]{1,2}\b+/i, '')

        text.downcase!
        text.strip!

        @@tokenizer.tokenize(text)
      end
    end
  end
end
