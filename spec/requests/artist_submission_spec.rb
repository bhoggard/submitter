feature "Artist Submissions" do
  include AuthHelper
  before(:each) do
    artist_login
  end

  def fill_in_work_form
    fill_in 'First name', with: 'Barry'
    fill_in 'Last name', with: 'Hoggard'
    fill_in 'E-mail address', with: 'bhoggard@example.com'
    fill_in 'Telephone', with: '212-627-1737'
    fill_in :website, with: 'http://bloggy.com'
    fill_in 'Name of committee member(s) who solicited your donation', with: 'Hannah'
    fill_in 'Work Title', with: 'Awesomeness'
    fill_in 'Year of Work', with: '2011'
    fill_in 'Materials', with: 'collage on paper'
    select '12', from: 'Height'
    select '14', from: 'Width'
    attach_file :image, "#{Rails.root}/app/assets/images/momenta-logo.gif"
  end

  scenario "Artist submits a work to the benefit" do
    visit guidelines_path
    page.should have_content("Submission Guidelines")
    click_link "Accept and continue"
    fill_in_work_form
    click_button 'Save Work'
    page.should have_content("Preview your submission")
    click_link "confirm it"
    page.should have_content('Thank you for submitting your work')
    work = Work.first
    work.confirmed.should be_true
  end

  scenario "Artist submits a work to the benefit and edits it after previewing" do
    visit guidelines_path
    page.should have_content("Submission Guidelines")
    click_link "Accept and continue"
    fill_in_work_form
    click_button 'Save Work'
    page.should have_content("Preview your submission")
    click_link "edit it"
    page.should have_content('Editing work')
    select '13', from: 'Width'
    click_button 'Save Work'
    page.should have_content("Preview your submission")
    click_link "confirm it"
    page.should have_content('Thank you for submitting your work')
  end

  scenario "Artist submits a work to the benefit with errors" do
    visit guidelines_path
    page.should have_content("Submission Guidelines")
    click_link "Accept and continue"
    fill_in_work_form
    fill_in 'First name', with: ''
    click_button 'Save Work'
    page.should have_content("Some errors were found, please take a look:")
    fill_in 'First name', with: 'James'
    attach_file :image, "#{Rails.root}/app/assets/images/momenta-logo.gif"
    click_button 'Save Work'
    page.should have_content("Preview your submission")
    click_link "confirm it"
    page.should have_content('Thank you for submitting your work')
  end

  scenario "Artist submits a work to the benefit and edits it (with errors) after previewing" do
    visit guidelines_path
    page.should have_content("Submission Guidelines")
    click_link "Accept and continue"
    fill_in_work_form
    click_button 'Save Work'
    page.should have_content("Preview your submission")
    click_link "edit it"
    page.should have_content('Editing work')
    select '13', from: 'Width'
    fill_in 'First name', with: ''
    click_button 'Save Work'
    page.should have_content("Some errors were found, please take a look:")
    fill_in 'First name', with: 'James'
    attach_file :image, "#{Rails.root}/app/assets/images/momenta-logo.gif"
    click_button 'Save Work'
    page.should have_content("Preview your submission")
    click_link "confirm it"
    page.should have_content('Thank you for submitting your work')
  end
end
