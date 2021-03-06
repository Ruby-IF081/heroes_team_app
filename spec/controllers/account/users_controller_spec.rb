require 'rails_helper'

RSpec.describe Account::UsersController, type: :controller do
  before :each do
    @user = FactoryBot.create(:user, :admin)
    sign_in @user
  end

  describe 'action #index' do
    context 'admin' do
      it 'should get the user of current tenant' do
        get :index
        expect(assigns(:users)).to contain_exactly(@user)
      end
      it 'should render the :index view' do
        get :index
        expect(response).to have_http_status(200)
        expect(response).to render_template(:index)
      end
    end

    context 'super_admin' do
      before :each do
        @super_admin = FactoryBot.create(:user, :super_admin)
        sign_out @user
        sign_in @super_admin
      end

      it 'should get all users when super-user' do
        get :index
        expect(assigns(:users)).to contain_exactly(@super_admin, @user)
        expect(response).to render_template(:index)
      end
    end
  end

  describe 'action #new' do
    it 'should initiate empty user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
    it 'should render the :new view' do
      get :new
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end
  end

  describe 'action #show' do
    context 'admin' do
      it 'should assign the requested user to @user' do
        get :show, params: { id: @user.id }
        expect(assigns(:user)).to eq(@user)
      end
      it 'should render the :show view' do
        get :show, params: { id: @user.id }
        expect(response).to have_http_status(200)
        expect(response).to render_template(:show)
      end
    end

    context 'super admin' do
      before :each do
        @super_user = FactoryBot.create(:user, :super_admin)
        sign_out @user
        sign_in @super_user
      end
      it 'should assign the requested user to @user' do
        get :show, params: { id: @user.id }
        expect(assigns(:user)).to eq(@user)
      end
      it 'should render the :show view for super admin' do
        get :show, params: { id: @user.id }
        expect(response).to have_http_status(200)
        expect(response).to render_template(:show)
      end
    end
  end

  describe 'action #create' do
    context 'with valid attributes' do
      let!(:val_user) { build(:user) }

      it 'should save a new user' do
        expect do
          post :create, params: { user: { first_name: val_user.first_name,
                                          last_name: val_user.last_name,
                                          email: val_user.email,
                                          role: val_user.role } }
        end.to change(User, :count).by(1)
      end

      it 'should redirect to the all users' do
        post :create, params: { user: { first_name: val_user.first_name,
                                        last_name: val_user.last_name,
                                        email: val_user.email,
                                        role: val_user.role } }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to account_users_path
        expect(controller).to set_flash[:success]
      end
    end
    context 'with invalid attributes' do
      it 'should not create a new user' do
        expect do
          post :create, params: { user: { first_name: 'Jo',
                                          last_name: nil,
                                          email: nil } }
        end.to_not change(User, :count)
      end

      it 'should render the new action again' do
        post :create, params: { user: { first_name: 'Jo',
                                        last_name: nil,
                                        email: nil } }
        expect(response).to have_http_status(200)
        expect(response).to render_template :new
        expect(controller).to set_flash[:danger]
      end
    end

    context 'tenant admin' do
      let!(:super_admin) { build(:user, role: User::SUPER_ADMIN_ROLE) }

      it 'should not create user with role super_admin' do
        expect do
          post :create, params: { id: super_admin.id,
                                  user: { first_name: super_admin.first_name,
                                          last_name: super_admin.last_name,
                                          email: super_admin.email,
                                          role: User::SUPER_ADMIN_ROLE } }
        end.to change(User, :count).by(1)
        saved_user = User.find_by(first_name: super_admin.first_name)
        expect(saved_user).not_to eq(super_admin)
        expect(saved_user.role).to eq(User::SALE_ROLE)
      end
    end
  end

  describe 'action #update' do
    context 'valid attributes' do
      it 'should locate the requested user' do
        put :update, params: { id: @user.id,
                               user: { first_name: @user.first_name,
                                       last_name: @user.last_name,
                                       email: @user.email } }
        expect(assigns(:user)).to eq(@user)
      end

      it "should change user's attributes" do
        put :update, params: { id: @user.id,
                               user: { first_name: 'Firstname',
                                       last_name: 'Lastname',
                                       email: 'email@mail.com',
                                       role: User::ADMIN_ROLE } }
        @user.reload
        expect(@user.first_name).to eq('Firstname')
        expect(@user.last_name).to eq('Lastname')
        expect(@user.email).to eq('email@mail.com')
        expect(@user.role).to eq(User::ADMIN_ROLE)
      end

      it 'should redirect to the users table' do
        put :update, params: { id: @user.id,
                               user: { first_name: 'Firstname',
                                       last_name: 'Lastname',
                                       email: 'email@mail.com',
                                       role: User::ADMIN_ROLE } }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to account_users_path
        expect(controller).to set_flash[:success]
      end
    end

    context 'invalid attributes' do
      it 'should locate the requested user' do
        put :update, params: { id: @user.id,
                               user: { first_name: @user.first_name,
                                       last_name: @user.last_name,
                                       email: @user.email } }
        expect(assigns(:user)).to eq(@user)
      end

      it "should not change user's attributes" do
        put :update, params: { id: @user.id,
                               user: { first_name: nil,
                                       last_name: nil,
                                       email: nil } }
        @user.reload
        expect(@user.first_name).to_not eq(nil)
        expect(@user.last_name).to_not eq(nil)
        expect(@user.email).to_not eq(nil)
      end

      it 'should re-renders the edit method' do
        put :update, params: { id: @user.id,
                               user: { first_name: nil,
                                       last_name: nil,
                                       email: nil } }
        expect(response).to have_http_status(200)
        expect(response).to render_template :edit
        expect(controller).to set_flash[:danger]
      end
    end
    context 'tenant admin' do
      it 'should not update a sale to role super_admin' do
        put :update, params: { id: @user.id,
                               user: { role: User::SUPER_ADMIN_ROLE } }
        @user.reload
        expect(@user.role).to_not eq(User::SUPER_ADMIN_ROLE)
      end
    end
  end

  describe 'action #edit' do
    it 'should get the user data for editing' do
      get :edit, params: { id: @user.id }
      expect(response).to have_http_status(200)
      expect(response).to render_template :edit
    end
  end

  describe 'action destroy a user' do
    it 'should delete the user' do
      expect { delete :destroy, params: { id: @user.id } }.to change(User, :count).by(-1)
    end

    it 'should redirect to user#index' do
      delete :destroy, params: { id: @user.id }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to account_users_path
      expect(controller).to set_flash[:success]
    end
  end

  describe 'action impersonate and stop_impersonating' do
    let!(:pretended_user) do
      create(:user, tenant_id: @user.tenant_id)
    end

    it 'should check if current tenant has the user to act as' do
      get :index
      expect(assigns(:users)).to contain_exactly(@user, pretended_user)
    end

    it 'admin should pretend as another user' do
      expect(subject.current_user).to eq(@user)
      post :impersonate, params: { id: pretended_user.id }
      expect(subject.current_user).not_to eq(@user)
      expect(response).to redirect_to root_path
      expect(subject.current_user).to eq(pretended_user)
      post :stop_impersonating
      expect(subject.current_user).to eq(@user)
      expect(response).to redirect_to root_path
    end
  end

  describe 'GET download' do
    it 'download csv' do
      get :download
      expect(response).to have_http_status(:success)
      expect(response.headers["Content-Type"]).to eq "text/csv"
      expect(response.headers["Content-Disposition"])
        .to eq "attachment; filename=\"Users #{Date.today}.csv\""
    end
  end
end
