require 'rails_helper'

RSpec.describe PhoneCodes::PrefixesQuery, type: :query do
  let! :phone_code1 { create(:phone_code, prefix: 69, usage: 'Mostly used by fish people') }

  subject { PhoneCodes::PrefixesQuery }

  it 'searches exact prefixes' do
    expect(subject.call(phone_code1.prefix).first).to eq(phone_code1)
  end

  it 'searches long numbers' do
    expect(subject.call(695553535).first).to eq(phone_code1)
  end

  it 'only searches prefixes in beginning of number'

  it 'works with dashed numbers normally'

  it 'works with whitespaced numbers normally'
end
