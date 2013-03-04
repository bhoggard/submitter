require 'spec_helper'

describe AdminController do

  it "requires login" do
    get :index
    response.should redirect_to(login_path)
  end
    
end
