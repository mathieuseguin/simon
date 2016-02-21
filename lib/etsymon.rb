$:.unshift File.dirname(__FILE__)

require 'json'

['model', 'listing', 'request', 'response', 'shop', 'version'].each do |file|
  require "etsymon/#{file}"
end


##
# API client for the ETSY API
#
# Use Etsy.api_key to specify your API key

module Etsymon
  class Error < RuntimeError; end
  class ShopNotFound < RuntimeError; end

  HOST = 'openapi.etsy.com'

  def self.api_key
    @api_key
  end

  def self.api_key=(key)
    @api_key ||= key
  end
end
