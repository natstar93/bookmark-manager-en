feature 'Adding tags' do

  scenario 'can add 1 tag to a new link' do
    visit 'links/new'
    fill_in 'title', with: 'http://www.makersacademy.com/'
    fill_in 'url', with: 'Makers Academy'
    fill_in 'tags', with: 'education'
    click_button 'Create link'
    link = Link.first
    expect(link.tags).to include('education')
  end

end