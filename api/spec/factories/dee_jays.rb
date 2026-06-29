FactoryBot.define do
  factory :dee_jay do
    name { Faker::Name.name }
    email { "#{Faker::Lorem.words(number: 3).join(".")}@gmail.com" }
    password { 'foobar' }
  end
end

