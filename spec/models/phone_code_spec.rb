require 'rails_helper'

RSpec.describe PhoneCode, type: :model do
  it 'is valid with valid inputs' do
    inputs = { prefix: 1511, max_len: 11, min_len: 11,
               usage: 'Mobile services', comment: 'Telekom Deutschland GmbH' }
    expect(PhoneCode.new(inputs)).to be_valid
  end
end
