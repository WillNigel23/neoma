RSpec.shared_context 'user_types' do
  let(:customer) { create(:user, role: :customer) }
  let(:admin) { create(:user, role: :admin) }
  let(:super_admin) { create(:user, role: :super_admin) }

  def login_as(user)
    post '/admin/users/sign_in', params: { v2_admin_user: { email: user.email, password: user.password } }
  end
end
