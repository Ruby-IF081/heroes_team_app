if Rails.env.production? 
  Tenant.create(name: "super")
  Tenant.create(name: "admin")
  Tenant.create(name: "sale")
  User.create(first_name: "super", last_name: "puper", email: "egor.odessa@gmail.com", role: "super_admin", password: "superteam", tenant: Tenant.find_by(name: "super"))
  User.create(first_name: "admin", last_name: "admin", email: "egor.odessa@gmail.com", role: "admin", password: "superteam", tenant: Tenant.find_by(name: "admin"))
  User.create(first_name: "sale", last_name: "sale", email: "egor.odessa@gmail.com", role: "sale", password: "superteam", tenant: Tenant.find_by(name: "sale"))
end

if Rails.env.development?
  FactoryBot.create(:user, email: 'admin@admin.com', password: '1qaz2wsx', role: 'admin')
  FactoryBot.create(:user, email: 'super_admin@super_admin.com', password: '1qaz2wsx', role: 'super_admin')
  FactoryBot.create(:user, email: 'sale@sale.com', password: '1qaz2wsx', role: 'sale')

  user = User.first
  tenant = Tenant.first

  FactoryBot.create(:company, name:  'Example Company',
                              domain: 'example.org',
                              user: user)

  FactoryBot.create(:company, name:  'SoftServe,Inc.',
                              domain: 'softserve.ua',
                              user: user)

  FactoryBot.create(:company, name:  'Alphabet Inc.',
                              domain: 'abc.xyz',
                              user: user)

  company = Company.first

  FactoryBot.create_list(:video, 20, videoable: company)

  FactoryBot.create_list(:tenant, 10)

  FactoryBot.create_list(:page, 20, :with_content, company: company)

  FactoryBot.create_list(:user, 200, :old_random_date, role: 'sale', tenant: tenant)

  FactoryBot.create_list(:company, 200, :old_random_date, user: user)

  FactoryBot.create_list(:visit, 200, :old_random_date, user: user, tenant_id: tenant.id)
end


