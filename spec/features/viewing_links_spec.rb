require 'models/link'

feature 'Viewing links' do

  scenario 'Can see links on links page' do
    Link.new(url: 'https://www.makersacademy.com', title: 'Makers Academy')
    visit '/links'
    expect(page.status_code).to eq 200

    within 'ul#links' do
      expect(page).to have_content('Makers Academy')
    end
  end
end