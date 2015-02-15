module AuthHelper
  def artist_login
    page.driver.browser.authorize(Rails.configuration.artist_auth_name,
                                  Rails.configuration.artist_auth_pass)
  end
end
