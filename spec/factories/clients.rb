
require 'faker'

FactoryGirl.define do
  factory :client do |f|
    f.surname { Faker::Name.last_name }
    f.name { Faker::Name.first_name }
    f.REGON '3129635478'
    f.PESEL '12345678910'
    f.city 'Warsaw'
    f.street 'Sloneczna 2'
  end
end