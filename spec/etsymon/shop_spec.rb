require 'spec_helper'

RSpec.describe Etsymon::Shop do
  before(:each) { Etsymon.api_key = 'abcd' }

  describe '#base_path' do
    before(:each) do
      stub_request(:get, 'https://openapi.etsy.com/v2/shops?api_key=abcd&shop_name=ShopName').
         with(headers: {
           'Accept': '*/*',
           'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
           'User-Agent': 'Ruby'
         }).
         to_return(
          status: 200, headers: {},
          body: '{"results": [{"shop_name": "test_name"}]}')
    end

    subject { Etsymon::Shop.find_by_name('ShopName') }

    it { expect(subject).to be_kind_of(Etsymon::Shop) }
    it { expect(subject.shop_name).to eq('test_name') }
  end
end
