require 'spec_helper'

RSpec.describe Etsymon::Request do
  before(:each) { Etsymon.api_key = 'abcd' }

  describe '#base_path' do
    subject { Etsymon::Request.new('/') }
    it { expect(subject.base_path).to eq('/v2') }
  end

  describe '#client' do
    context 'when using SSL' do
      subject { Etsymon::Request.new('/') }
      it { expect(subject.client).to be_kind_of(Net::HTTP) }
      it { expect(subject.client.use_ssl?).to be_truthy }
    end

    context 'when using not SSL' do
      subject { Etsymon::Request.new('/', use_ssl: false) }
      it { expect(subject.client).to be_kind_of(Net::HTTP) }
      it { expect(subject.client.use_ssl?).to be_falsy }
    end
  end

  describe '#get' do
    subject { Etsymon::Request.new('/shops/YieldDesignCo') }

    before(:each) do
      stub_request(:get, 'https://openapi.etsy.com/v2/shops/YieldDesignCo?api_key=abcd').
               with(headers: {
                 'Accept': '*/*',
                 'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                 'User-Agent': 'Ruby'
                }).
               to_return(status: 200, body: '{}', headers: {})
    end

    it { expect(subject.get).to be_kind_of(Net::HTTPOK) }
    it { expect(subject.get.body).to eq('{}') }
  end

  describe '#url' do
    subject { Etsymon::Request.new('/shops/YieldDesignCo', test: 'ok') }
    it { expect(subject.url).to eq('/v2/shops/YieldDesignCo?api_key=abcd&test=ok') }
  end

  describe '.get' do
    subject { Etsymon::Request.get('/shops/YieldDesignCo') }

    before(:each) do
      stub_request(:get, 'https://openapi.etsy.com/v2/shops/YieldDesignCo?api_key=abcd').
               with(headers: {
                 'Accept': '*/*',
                 'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                 'User-Agent': 'Ruby'
                }).
               to_return(status: 200, body: '{}', headers: {})
    end

    it { expect(subject).to be_kind_of(Etsymon::Response) }
    it { expect(subject.data).to eq('{}') }
    it { expect(subject.json).to be_kind_of(Hash) }
  end
end
