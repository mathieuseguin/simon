module Etsymon

  ##
  # HTTP Response wrapper

  class Response
    def initialize(raw_response)
      @raw_response = raw_response
    end


    ##
    # Returns the raw response body.

    def data
      @raw_response.body
    end


    ##
    # Returns the parsed response body.

    def json
      @hash ||= ::JSON.parse(data)
    end
  end
end
