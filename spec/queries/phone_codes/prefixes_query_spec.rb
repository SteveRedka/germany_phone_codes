require 'rails_helper'

RSpec.describe PhoneCodes::PrefixesQuery, type: :query do
  let! :phone_code1 { create(:phone_code, prefix: 69, usage: 'Mostly used by fish people') }
  let! :single_digit_code { create(:phone_code, prefix: 9, usage: 'glob') }

  subject { PhoneCodes::PrefixesQuery }

  describe '#call' do
    it 'searches exact prefixes' do
      expect(subject.call(phone_code1.prefix).first).to eq(phone_code1)
    end

    it 'searches long numbers' do
      expect(subject.call(695553535).first).to eq(phone_code1)
    end

    it 'only searches prefixes in beginning of number' do
      expect(subject.call(111695553).first).to be_nil
    end

    it 'handles single-digit prefixes' do
      expect(subject.call(single_digit_code.prefix).first).to eq(single_digit_code)
    end
  end

  describe '#list_possible_prefixes' do
    it 'handles valid codes' do
      valid_codes = %w[069 +4969 +49(0)69 004969 (069) 069-123 069/]
      valid_codes.each do |code|
        error_msg = "Failing phone code: #{code}"
        expect(subject.list_possible_prefixes(code)).to include('69', '6'), error_msg
      end
    end
  end
end
