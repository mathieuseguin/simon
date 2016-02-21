require 'spec_helper'

RSpec.describe Etsymon::Response do
  subject do
    res = double
    allow(res).to receive(:body) { '{"test": true}' }
    Etsymon::Response.new(res)
  end

  it { expect(subject.data).to eq('{"test": true}') }
  it { expect(subject.json).to be_kind_of(Hash) }
  it { expect(subject.json['test']).to eq(true) }
end
