require 'rails_helper'

RSpec.describe Tenant, type: :model do

  it 'has a valid factory' do
    expect(build(:tenant)).to be_valid
  end

  it do
    should validate_length_of(:name).
      is_at_least(3).is_at_most(64)
  end

  it do
    should validate_length_of(:website).
      is_at_least(3).is_at_most(64)
  end
end
