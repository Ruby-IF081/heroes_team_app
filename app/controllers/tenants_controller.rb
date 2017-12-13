class TenantsController < ApplicationController
  def index
    @tenants = Tenant.all
  end

  def show
    @tenant = Tenant.find(params[:id])
  end

  def new
    @tenant = Tenant.new
  end

  def create
    @tenant = Tenant.new(tenant_params)
    if @tenant.save
      redirect_to tenants_path
    else
      render 'new'
    end
  end

  def edit
    @tenant = Tenant.find(params[:id])
  end

  def update
    @tenant = Tenant.find(params[:id])
    if @tenant.update_attributes(tenant_params)
      flash[:success] = "Information is updated"
      redirect_to @tenant
    else
      render 'edit'
    end
  end

  def destroy
    Tenant.find(params[:id]).destroy
    flash[:success] = "Tenant is deleted"
  end

  private

  def tenant_params
    params.require(:tenant).permit(:name, :website, :phone, :logo)
  end
end
