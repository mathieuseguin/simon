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
