feature 'Creating links' do

  scenario 'creating new links' do
    visit '/links/new'
    fill_in 'url', with: 'https://www.zombo.com/'
    fill_in 'title', with: 'Zombocom'
    click_button 'Create link'
    expect(current_path).to eq '/links'

    within 'ul#links' do
      expect(page).to have_content('Zombocom')
    end
  end
end