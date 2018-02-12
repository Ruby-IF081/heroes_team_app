# == Schema Information
#
# Table name: pages
#
#  id           :integer          not null, primary key
#  page_type    :string
#  title        :string
#  content_html :string
#  content      :string
#  source_url   :string
#  status       :string
#  screenshot   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  company_id   :integer
#  rating       :integer          default(0)
#

require 'rails_helper'

RSpec.describe Page, type: :model do
  let!(:company) { create :company }
  let!(:first_page) { create :page, company: company, rating: 50 }
  let!(:second_page) { create :page, company: company, rating: 100 }

  it 'has a valid factory' do
    expect(first_page).to be_valid
  end

  it 'page max_rating should be correct' do
    expect(first_page.max_rating).to eq(100)
    expect(second_page.max_rating).to eq(100)
  end

  it 'page rating_progress should be correct' do
    expect(first_page.rating_progress).to eq(50)
    expect(second_page.rating_progress).to eq(100)
  end
end
