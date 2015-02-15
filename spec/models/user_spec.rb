require 'rails_helper'

RSpec.describe User, type: :model do
  context "a regular user" do
    before(:all) do
      @user = create_user!
    end

    it "should be authenticated via its password" do
      u = User.find_by_name(@user.name)
      expect(u.authenticate('password')).to be_truthy
      expect(u.authenticate('not my password')).to be false
    end
  end
end
