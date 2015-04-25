# rubocop:disable LineLength
class HomeController < ApplicationController
  unless Rails.configuration.post_raffle
    http_basic_authenticate_with name: Rails.configuration.artist_auth_name,
                                 password: Rails.configuration.artist_auth_pass, only: :submit
  end

  before_filter :set_caching, only: [:index, :thank_you, :submit]

  def index
  end

  # start page for artist work submission
  def submit
  end

  # confirm that artist accepts guidelines
  def accept
    session[:accept] = 1
    redirect_to new_work_path
  end

  # thank you page after submission
  def thank_you
  end
end
