require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to(:user) }
  it 'has a polymorphic relationship' do
    expect(subject).to belong_to(:commentable)
    expect(subject).to have_db_column(:commentable_id).of_type(:integer)
    expect(subject).to have_db_column(:commentable_type).of_type(:string)
  end
  it 'has a valid factory' do
    expect(build(:comment)).to be_valid
  end
end
