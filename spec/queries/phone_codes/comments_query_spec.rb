require 'rails_helper'

RSpec.describe PhoneCodes::CommentsQuery, type: :query do
  denormalized = 'ä ö ü ß'
  normalized = 'ae oe ue ss'
  let! :code_with_umlauts { create(:phone_code, comment: denormalized) }

  subject { PhoneCodes::CommentsQuery }

  describe 'text search' do
    describe 'umlauts' do
      it 'accept accents as search inputs' do
        expect(subject.call(denormalized).first).to eq(code_with_umlauts)
      end

      it 'performs search according to accent transformation rules' do
        expect(subject.call(normalized).first).to eq(code_with_umlauts)
      end

      it 'performs search with unaccented umlauts' do
        unaccented = 'a o u s'
        expect(subject.call(unaccented).first).to eq(code_with_umlauts)
      end
    end
  end
end
