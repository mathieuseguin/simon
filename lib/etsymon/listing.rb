module Etsymon

  ##
  # Etsy API wrapper for the Listing model

  class Listing
    include Model

    def initialize(data)
      @data = data
    end

    class << self

      ##
      # Find all the listings by shop_id, looping through all the pages
      #
      # Default:
      #   - limit: 100
      #   - offset: 0
      #
      # Limits the number of requests per seconds by pausing for X ms.

      def find_all_by_shop_id(shop_id, opts = {})
        listings = []

        while(true)
          begin
            opts = { limit: 100, offset: 0 }.merge(opts)
            res = Request.get("/shops/#{shop_id}/listings/active", opts)
          rescue => e
            raise Error, e.message
            break
          end
          
          if res.code == '404'
            raise ShopNotFound, "Shop with id: #{shop_id} was not found."
          elsif res.code == '200'
            if res.json && res.json['results'].any?
              listings += res.json['results'].map do |listing_data|
                self.new(listing_data)
              end

              opts[:offset] += res.json['results'].length
            else
              break
            end
          else
            raise Error
          end
        end

        listings
      end


      ##
      # Find all listings using the shop's name
      #
      # Default:
      #   - limit: 100
      #   - offset: 0

      def find_all_by_shop_name(shop_name, opts = {})
        shop_id = Shop.find_by_name(shop_name).shop_id
        find_all_by_shop_id(shop_id, opts) if shop_id
      end
    end
  end
end
