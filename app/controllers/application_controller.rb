class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user  
    @current_user ||= User.find(session[:user_id]) if session[:user_id]  
  end  
  
  helper_method :current_user


  def admin?
    false
  end
  
  private

  def set_caching
    response.headers['Cache-Control'] = 'public, max-age=1800'
  end
  
  # check whether admin is logged in
  def authenticate!
    unless current_user
      redirect_to login_path, notice: 'You must be logged in to visit that page'
    end
  end

  def load_work
    @work = Work.find(params[:id])
  end

end