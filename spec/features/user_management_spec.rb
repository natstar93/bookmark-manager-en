require 'launchy'


feature 'User sign up' do 

  scenario 'I can sign up as a new user' do 
    expect { sign_up }.to change(User, :count).by(1)
    visit '/'
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end

  scenario 'requires a matching confirmation password' do
    expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
    expect(current_path).to eq('/users') #current_path is a helper provided by Capybara
    expect(page).to have_content 'Password does not match the confirmation'
  end

  #Write a feature test to ensure a user can't sign up without entering an email
  scenario 'user can not sign up without entering an email address' do
    expect { sign_up(email: '') }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Email must not be blank'
  end

  scenario 'I cannot sign up with an existing email' do 
    user = build :user
    sign_up_as(user)
    expect { sign_up_as(user) }.to change(User, :count).by(0)
    expect(page).to have_content('Email is already taken')
  end

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

end

feature 'User sign in' do

  let(:user) do
      User.create(email: 'user@example.com',
                   password: 'secret1234',
                   password_confirmation: 'secret1234')
     end

     scenario 'with correct credentials' do
       sign_in(email: user.email,   password: user.password)
       expect(page).to have_content "Welcome, #{user.email}"
     end

     def sign_in(email:, password:)
       visit '/sessions/new'
       fill_in :email, with: email
       fill_in :password, with: password
       click_button 'Login'
     end

end
