
require 'faker'

FactoryGirl.define do
  factory :client do |f|
    f.surname { Faker::Name.last_name }
    f.name { Faker::Name.first_name }
  end
end