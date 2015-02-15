require 'rails_helper'

RSpec.describe Admin::WorksController, type: :controller do
  it "requires login" do
    get :index
    expect(response).to redirect_to(login_path)
  end
end
