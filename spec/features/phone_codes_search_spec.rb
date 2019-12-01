require 'spec_helper'

feature 'User searches phone codes', js: true do
  before do
    @phone_code_with_low_id = create(:phone_code, prefix: 69, usage: 'Mostly used by fish people')
    create_list(:phone_code, 25)
    @phone_code_with_high_id = create(:phone_code, prefix: 9999, min_len: 6, max_len: 11, usage: 'Saint-Petersburg')
  end

  scenario 'loads page and some entries with no inputs' do
    visit '/'
    expect(page).to have_css('.table')
    expect(page).to have_css('.table tbody tr')
    expect(page).to have_content(@phone_code_with_low_id.usage)
    expect(page).to have_content(@phone_code_with_low_id.prefix)
  end

  scenario 'through search input' do
    visit '/'
    fill_in 'phone-code-search-input', with: @phone_code_with_high_id.usage
    expect(page).to have_content(@phone_code_with_high_id.usage)
    expect(page).not_to have_content(@phone_code_with_low_id.usage)
  end

  describe 'Pagination' do
    before do
      created_users = create_list(:phone_code, 25)
      visit '/'
    end

    scenario 'clicking pagination links' do
      expect(page).to have_content(@phone_code_with_low_id.comment)
      expect(page).not_to have_content(@phone_code_with_high_id.comment)
      find('.pagination-next-item').click()
      expect(page).not_to have_content(@phone_code_with_low_id.comment)
      expect(page).to have_content(@phone_code_with_high_id.comment)
      find('.pagination-prev-item').click()
      expect(page).to have_content(@phone_code_with_low_id.comment)
      expect(page).not_to have_content(@phone_code_with_high_id.comment)
    end
  end
end
