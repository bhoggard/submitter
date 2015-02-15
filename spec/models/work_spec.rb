require 'rails_helper'

RSpec.describe Work, type: :model do
  it "must have a valid email" do
    work = Factory.build(:work, email: 'hey')
    f = File.open("#{Rails.root}/app/assets/images/momenta-logo.gif")
    work.image = f
    expect(work).to be_invalid
  end

  it "must have a valid website if one is provided" do
    work = Factory.build(:work, website: 'http://www.karlaknight.org/')
    f = File.open("#{Rails.root}/app/assets/images/momenta-logo.gif")
    work.image = f
    expect(work).to be_valid
    work.website = 'bloggy.com'
    expect(work).not_to be_valid
  end
end
