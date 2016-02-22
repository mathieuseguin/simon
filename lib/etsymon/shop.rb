module Etsymon

  ##
  # Etsy API wrapper for the Shop model

  class Shop
    include Model

    def initialize(data)
      @data = data
    end

    ##
    # Get all the listings for the curent shop

    def listings
      @listings ||= Listing.find_all_by_shop_id(shop_id)
    end

    alias_method :get_listings, :listings


    ##
    # Get the top terms from specified fields of all the listings for the current shop
    # default fields: title, description

    def top_terms(opts = {})
      opts = {fields: ['title', 'description'], count: 5}.merge(opts)
      term = Term.new

      listings.each do |listing|
        opts[:fields].each do |field|
          term.add_sentence(listing.send(field))
        end
      end

      term.top(opts[:count])
    end


    class << self
      ##
      # Find a shop by its name
      # Returns an Etsymon::Shop object

      def find_by_name(name)
        res = Request.get('/shops', shop_name: name)

        if res.code == '404'
          raise ShopNotFound, "Shop with name: #{name} was not found."
        elsif res.code == '200'
          res.json['results'].any? ? self.new(res.json['results'].first) : nil
        end
      end
    end
  end
end
