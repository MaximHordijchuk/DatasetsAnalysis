module SpecSessionsHelper
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = User.create({ username: 'Jonh', password: '123456' })
      sign_in @user
    end
  end
end