module Etsymon

  ##
  # HTTP Client wrapper for the Etsy API V2 client

  class Request
    ##
    # Request constructor
    #
    # Arguments:
    #   - path (string): the request path to the resource
    #   - params (hash):
    #     - base_path (string): Etsy API's version to use. default: /v2
    #     - use_ssl (boolean): Whether or not the calls should be encrypted

    def initialize(path, params = {})
      params = {base_path: '/v2', use_ssl: true}.merge(params)
      @path = path
      @base_path = params.delete(:base_path)
      @use_ssl = params.delete(:use_ssl)
      @params = params
    end


    ##
    # Returns a Net::HTTP client configured for the Etsy's API

    def client
      if @client.nil?
        @client = ::Net::HTTP.new(Etsymon::HOST, @use_ssl ? 443 : 80)
        @client.use_ssl = @use_ssl
      end

      @client
    end


    ##
    # Forwards the get request to the Net:HTTP client

    def get
      client.get(url)
    end


    ##
    # Builds the full URL using the API version, API key
    # and the request parameters
    #
    # Returns a URL string

    def url
      url = "#{@base_path}#{@path}?api_key=#{Etsymon.api_key}"
      url += @params.map{|k,v| "&#{k}=#{v}" }.join('')
      url
    end


    ##
    # Make a get request to the Etsy's API.
    # Takes the same arguments than the Estymon::Request constructor.
    #
    # Returns an Etsymon::Response object.

    class << self
      def get(path, opts = {})
        req = Request.new(path, opts)
        Response.new(req.get)
      end
    end
  end
end
