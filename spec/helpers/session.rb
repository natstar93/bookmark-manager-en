module SessionHelpers
  def sign_up_as(user)
      visit '/users/new'
      fill_in :email, with: user.email
      fill_in :password, with: user.password
      fill_in :password_confirmation, with: user.password_confirmation
      click_button 'Sign up'
  end

  def sign_up(  email: 'alice@example.com',
                password: '12345678',
                password_confirmation: '12345678')
      visit '/users/new'
      fill_in :email, with: email
      fill_in :password, with: password 
      fill_in :password_confirmation, with: password_confirmation
      click_button 'Sign up'
  end
  def sign_in(email:, password:)
     visit '/sessions/new'
     fill_in :email, with: email
     fill_in :password, with: password
     click_button 'Login'
   end
end