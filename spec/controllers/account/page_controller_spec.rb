require 'rails_helper'

RSpec.describe Account::PagesController, sidekiq: true, type: :controller do
  context 'Page' do
    let!(:page) { create(:page) }
    before(:each) { sign_in page.company.user }

    it 'GET #index' do
      get :index, params: { company_id: page.company.to_param }
      expect(response).to have_http_status(:success)
    end

    it 'GET #show' do
      get :index, params: { company_id: page.company.to_param, id: page }
      expect(response).to have_http_status(:success)
    end

    it 'PATCH #rate with valid values' do
      new_rating = 100
      patch :rate, params: { company_id: page.company.to_param,
                             id: page, page: { rating: new_rating } }
      page.reload
      expect(page.rating).to eq(new_rating)
    end

    it 'PATCH #rate with invalid values' do
      old_rating = page.rating
      invalid_rating = 1_000_000
      patch :rate, params: { company_id: page.company.to_param,
                             id: page, page: { rating: invalid_rating } }
      page.reload
      expect(page.rating).to eq(old_rating)
    end
  end

  context 'Page by ajax' do
    render_views
    before(:each) do
      @user = FactoryBot.create(:user)
      sign_in @user
    end
    let!(:company) { create :company, user_id: @user.id }
    let!(:valid_page) { build :page, company: company }
    it 'should create a new page' do
      expect do
        post :create, xhr: true, params: { company_id: company.id,
                                           id: valid_page.id,
                                           page: { title: 'google',
                                                   source_url: 'google.com' } }
      end.to change(Page, :count).by(1)
    end
    it 'should not create a new page' do
      expect do
        post :create, xhr: true, params: { company_id: company.id,
                                           id: valid_page.id,
                                           page: { title: 'google',
                                                   source_url: '' } }
      end.not_to change(Page, :count)
    end
  end

  describe 'DELETE #destroy' do
    render_views
    before(:each) do
      @user = FactoryBot.create(:user, :admin)
      sign_in @user
    end
    let!(:company) { create :company, user_id: @user.id }
    let!(:page) { create :page, company: company }

    context 'success' do
      subject { delete :destroy, xhr: true, params: { company_id: company.id, id: page.id } }

      it 'renders template' do
        expect(subject).to render_template(:destroy)
      end

      it 'deletes something' do
        expect { subject }.to change(Page, :count).by(-1)
      end
    end

    context 'error' do
      before :each do
        @sale = FactoryBot.create(:user, :sale, tenant_id: @user.tenant_id)
        sign_out @user
        sign_in @sale
      end
      let!(:sale_company) { create :company, user_id: @sale.id }
      let!(:sale_page) { create :page, company: sale_company }

      subject do
        delete :destroy, xhr: true, params: { company_id: sale_company.id,
                                              id: sale_page.id }
      end

      it 'does not delete record' do
        expect { subject }.to change(Page, :count).by(0)
      end

      it 'responds with JS alert' do
        subject
        expect(response.body).to include("alert('No rights to delete this page')")
      end
    end
  end
end
