require 'spec_helper'

def stub_listing_request(opts = {})
  opts = {
    id: 1234, offset: 0, status: 200, headers: {},
    body: '{"count":2,"results":[{"listing_id":123},{"listing_id":456}]}'
  }.merge(opts)

  url =  "https://openapi.etsy.com/v2/shops/#{opts[:id]}/listings/active"
  url += "?api_key=abcd&limit=100&offset=#{opts[:offset]}"

  headers = { 'Accept': '*/*', 'User-Agent': 'Ruby',
              'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3' }

  stub_request(:get, url).with(headers: headers)
    .to_return(status: opts[:status], headers: opts[:headers], body: opts[:body])
end

RSpec.describe Etsymon::Listing do
  before(:each) { Etsymon.api_key = 'abcd' }

  describe '.find_all_by_shop_id' do
    subject { Etsymon::Listing.find_all_by_shop_id(1234) }

    context 'valid' do
      before(:each) do
        stub_listing_request
        stub_listing_request(offset: 2, body: '{"count":0,"results":[]}')
      end

      it { expect(subject).to be_kind_of(Array) }
      it { expect(subject.first).to be_kind_of(Etsymon::Listing) }
    end

    context 'not valid' do
      before(:each) do
        stub_listing_request(status: 404, body: "'1234' is not a valid shop name")
      end

      it { expect { subject }.to raise_error(Etsymon::ShopNotFound) }
    end
  end

  describe '.find_all_by_shop_name' do
    context 'valid' do
      subject { Etsymon::Listing.find_all_by_shop_name('ShopName') }

      before(:each) do
        stub_request(:get, 'https://openapi.etsy.com/v2/shops?api_key=abcd&shop_name=ShopName').
           with(headers: { 'Accept': '*/*', 'User-Agent': 'Ruby',
                           'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3' }
           ).to_return(status: 200, headers: {}, body: '{"results": [{"shop_id": 1234}]}')
        stub_listing_request
        stub_listing_request(offset: 2, body: '{"count":0,"results":[]}')
      end

      it { expect(subject).to be_kind_of(Array) }
      it { expect(subject.first).to be_kind_of(Etsymon::Listing) }
    end

    context 'not valid' do
      before(:each) do
        stub_request(:get, 'https://openapi.etsy.com/v2/shops?api_key=abcd&shop_name=1234').
           with(headers: { 'Accept': '*/*', 'User-Agent': 'Ruby',
                           'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
           }).to_return(status: 404, headers: {}, body: "'1234' is not a valid shop name")
      end

      subject { Etsymon::Listing.find_all_by_shop_name('1234') }

      it { expect{ subject }.to raise_error(Etsymon::ShopNotFound) }
    end
  end
end
