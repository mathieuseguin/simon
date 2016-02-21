##
# Etsy API wrapper for the Shop model

module Etsymon
  class Shop
    def initialize(data)
      @data = data
    end

    ##
    # Syntactic sugar for using the data fields using instance methods

    def method_missing(method_sym)
      @data[method_sym.to_s] rescue nil
    end

    class << self
      ##
      # Find a shop by its name
      # Returns an Etsy::Shop object

      def find_by_name(name)
        data = Request.get('/shops', shop_name: name).json
        data['results'].any? ? self.new(data['results'].first) : nil
      end
    end
  end
end
