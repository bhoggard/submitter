# Read about factories at http://github.com/thoughtbot/factory_girl

FIRST_NAMES = %W{ Barry James Anne Michelle }
LAST_NAMES = %W{ Hoggard Wagner Jones Smith }
TITLES = %W{ Boy Tree Girl Mountain Untitled Awesomeness }
MEDIA = [ 'c-print', 'oil on canvas', 'collage on paper', 'video' ]
EDITION = [ '1 of 3', 'artist proof', '', '', '' ]


FactoryGirl.define do

  sequence :email do |n|
    "email#{n}@example.com"
  end

  factory :work do
    first_name { FIRST_NAMES.sample }
    last_name { LAST_NAMES.sample }
    email 
    phone "212-627-1737"
    committee_member { FIRST_NAMES.sample + " " + LAST_NAMES.sample }
    title { TITLES.sample }
    year { (2001 + Random.rand(12)).to_s }
    materials { MEDIA.sample }
    height { Random.rand(17) + 1 }
    width { Random.rand(17) + 1 }
    length ""
    edition { EDITION.sample }
    estimated_value { (Random.rand(20) + 1) * 50 }
    courtesy { "the artist and #{LAST_NAMES.sample} Gallery" }
  end
end
