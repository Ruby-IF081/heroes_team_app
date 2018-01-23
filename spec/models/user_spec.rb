require 'rails_helper'

describe User, type: :model do
  let!(:user) { build(:user) }

  it { should belong_to(:tenant) }
  it { should have_many(:companies) }
  it { should accept_nested_attributes_for(:tenant) }
  it "full_name method" do
    expect(user.full_name).to eq("#{user.first_name} #{user.last_name}")
  end
  it "admin? method" do
    user.role = User::ADMIN_ROLE
    expect(user.admin?).to be true
  end
  it "super_admin? method" do
    user.role = User::SUPER_ADMIN_ROLE
    expect(user.super_admin?).to be true
  end
end
