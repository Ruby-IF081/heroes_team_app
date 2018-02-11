require 'rails_helper'
RSpec.describe NotificationBuilder do
  let!(:page) { create(:page) }
  let!(:company) { page.company }

  it 'should create two notifications' do
    expect do
      NotificationBuilder
        .new(content: page)
        .success("Page #{page.id} was successful processed")
        .create
      NotificationBuilder
        .new(content: company)
        .error("Company #{company.id} was failed")
        .create
    end.to change(Notification, :count).by(2)
  end
end
