feature "Admin Login" do
  before(:all) do
    @admin = create_user!
  end

  scenario "Admin user logs in and out" do
    visit login_path
    fill_in "User Name", with: @admin.name
    fill_in "Password",  with: 'password'
    click_button "Login"
    expect(page).to have_content("Total works submitted:")
    click_link "Logout"
    expect(page).to have_content("Logged out!")
  end
end
