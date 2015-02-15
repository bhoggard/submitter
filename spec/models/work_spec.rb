require 'spec_helper'

describe Work do
  it "must have a valid email" do
    work = Factory.build(:work, email: 'hey')
    f = File.open("#{Rails.root}/app/assets/images/momenta-logo.gif")
    work.image = f
    work.valid?.should be_false
  end

  it "must have a valid website if one is provided" do
    work = Factory.build(:work, website: 'http://www.karlaknight.org/')
    f = File.open("#{Rails.root}/app/assets/images/momenta-logo.gif")
    work.image = f
    work.valid?.should be_true
    work.website = 'bloggy.com'
    work.valid?.should be_false
  end
end
