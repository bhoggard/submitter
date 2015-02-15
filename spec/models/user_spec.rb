require 'spec_helper'

describe User do
  context "a regular user" do
    before(:all) do
      @user = create_user!
    end

    it "should be authenticated via its password" do
      u = User.find_by_name(@user.name)
      u.authenticate('password').should be_true
      u.authenticate('not my password').should be_false
    end
  end
end
