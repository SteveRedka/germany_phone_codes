require 'rails_helper'

RSpec.describe WordAndPrefixSearchQuery, type: :query do
  let! :phone_code1 { create(:phone_code, prefix: 1, usage: 'Mostly used by fish people') }
  let! :dashed_code { create(:phone_code, prefix: 812, min_len: 6, max_len: 11, usage: 'Saint-Petersburg') }
  let! :umlaut_code { create(:phone_code, prefix: 2296, min_len: 6, max_len: 11, usage: 'Reichshof-Brüchermühle') }

  subject { WordAndPrefixSearchQuery }

  describe 'text search' do
    it 'finds normal text' do
      result = subject.call('fish')
      expect(result.length).to eq(1)
      expect(result.first).to eq(phone_code1)
    end

    it 'doesnt find wrong items' do
      result = subject.call('pluto')
      expect(result).to be_empty
    end

    it 'finds weird umlauted entries if you look them up with normal latin letters'

    it 'works with dashes normally' do
      result = subject.call('t-peter')
      expect(result.first).to eq(dashed_code)
    end

    it 'works with empty query' do
      expect(subject.call('').length).to eq(PhoneCode.all.length)
    end
  end

  describe 'prefix and text' do
    it 'does OR search if you enter prefix and text'
  end

  describe 'prefix' do
    it 'searches exact prefixes'

    describe 'prefix splitting' do
      it 'tries to split entered number to find an exact prefix'
    end

    it 'works with dashed numbers normally'

    it 'works with whitespaced numbers normally'
  end
end
