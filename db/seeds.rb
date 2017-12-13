FactoryBot.create_list(:page, 20)

Tenant.create!(name:  'First Tenant',
	       phone: '1-35-300-452'
               website: 'domain.com')

Tenant.create!(name:  'Second Tenant',
	       phone: '+44 20 7234 3456'
               website: 'second.org')
