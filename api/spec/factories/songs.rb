FactoryBot.define do
  factory :song do
    words = Faker::Lorem.words(number: 2)
    title { "#{words.first} #{words.last}" }
    comment { Faker::Lorem.words(number: 5).join(" ") }
  end
end
