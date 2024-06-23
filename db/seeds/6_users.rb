User.destroy_all

FactoryBot.create(:user, email: 'customer@email.com', role: :customer)
FactoryBot.create(:user, email: 'admin@domain.com', role: :admin)
FactoryBot.create(:user, email: 'super_admin@domain.com', role: :super_admin)
