require 'spec_helper'

RSpec.describe Etsymon::Shop do
  before(:each) { Etsymon.api_key = 'abcd' }

  describe '#listings' do
    subject { Etsymon::Shop.new('shop_id' => 1234) }

    context 'valid' do
      before(:each) do
        stub_listing_request
        stub_listing_request(offset: 2, body: '{"count":0,"results":[]}')
      end

      it { expect(subject.listings).to be_kind_of(Array) }
      it { expect(subject.listings.first).to be_kind_of(Etsymon::Listing) }
    end
  end

  describe '.find_by_name' do
    context 'valid' do
      before(:each) do
        stub_request(:get, 'https://openapi.etsy.com/v2/shops?api_key=abcd&shop_name=ShopName').
           with(headers: {
             'Accept': '*/*', 'User-Agent': 'Ruby',
             'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
           }).to_return(status: 200, headers: {}, body: '{"results": [{"shop_name": "test_name"}]}')
      end

      subject { Etsymon::Shop.find_by_name('ShopName') }

      it { expect(subject).to be_kind_of(Etsymon::Shop) }
      it { expect(subject.shop_name).to eq('test_name') }
    end

    context 'not valid' do
      before(:each) do
        stub_request(:get, 'https://openapi.etsy.com/v2/shops?api_key=abcd&shop_name=1234').
           with(headers: { 'Accept': '*/*', 'User-Agent': 'Ruby',
                           'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
           }).to_return(status: 404, headers: {}, body: "'1234' is not a valid shop name")
      end

      subject { Etsymon::Shop.find_by_name('1234') }

      it { expect{ subject }.to raise_error(Etsymon::ShopNotFound) }
    end
  end
end
