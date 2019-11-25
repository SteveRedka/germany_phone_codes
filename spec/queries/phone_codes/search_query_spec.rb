require 'rails_helper'

RSpec.describe PhoneCodes::SearchQuery, type: :query do
  let! :phone_code1 { create(:phone_code, prefix: 69, usage: 'Mostly used by fish people') }
  let! :dashed_code { create(:phone_code, prefix: 812, min_len: 6, max_len: 11, usage: 'Saint-Petersburg') }

  subject { PhoneCodes::SearchQuery }

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

    it 'works with dashes normally' do
      result = subject.call('t-peter')
      expect(result.first).to eq(dashed_code)
    end

    it 'works with empty query' do
      expect(subject.call.length).to eq(PhoneCode.all.length)
    end
  end

  describe 'prefix and text' do
    it 'does OR search if you enter prefix and text' do
      # subject.call()
    end
  end
end
