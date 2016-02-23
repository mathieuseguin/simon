require 'spec_helper'

RSpec.describe Etsymon::Term do
  subject { Etsymon::Term.new }

  describe '#add_sentence' do
    before { subject.add_sentence("ToKenize Business my WoRds and http://url.com") }
    it { expect(subject.tokens).to eq('tokenize' => 1, 'business' => 1, 'word' => 1) }
  end

  describe '#add_tokens' do
    before { subject.add_tokens(['tokenize', 'business', 'word']) }
    it { expect(subject.tokens).to eq('tokenize' => 1, 'business' => 1, 'word' => 1) }
  end

  describe '#top' do
    before do
      ['Geo Stand - Triangle', 'Geo Stand - Circle', 'Geo Stand - Square', 'French Square Press'].each do |sentence|
        subject.add_sentence(sentence)
      end
    end
    it { expect(subject.top(5)).to eq([["geo", 3], ["stand", 3], ["square", 2], ["circle", 1], ["triangle", 1]]) }
  end

  describe '.extract_tokens' do
    it { expect(Etsymon::Term.extract_tokens('SmaLL Case WorDs')).to eq(['small', 'case', 'word']) }
    it { expect(Etsymon::Term.extract_tokens('remove 2 ch words')).to eq(['remove', 'word']) }
  end
end
