FactoryBot.define do
  factory :album do
    title { "#{Faker::Lorem.words(number: 4).join(" ")}" }
  end
end
