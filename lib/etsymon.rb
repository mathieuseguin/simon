$:.unshift File.dirname(__FILE__)

require 'json'
require 'etsymon/request'
require 'etsymon/response'
require 'etsymon/shop'
require 'etsymon/version'


##
# API client for the ETSY API
#
# Use Etsy.api_key to specify your API key

module Etsymon
  HOST = 'openapi.etsy.com'

  def self.api_key
    @api_key
  end

  def self.api_key=(key)
    @api_key ||= key
  end
end
