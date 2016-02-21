require 'spec_helper'

RSpec.describe Etsymon do
  it 'configures the API key' do
    Etsymon.api_key = 'abcd'
    expect(Etsymon.api_key).to eq('abcd')
  end
end
