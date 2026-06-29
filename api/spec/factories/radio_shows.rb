FactoryBot.define do
  factory :radio_show do
    publish_date { Faker::Date.between(from: 90.days.ago, to: 5.days.ago) }
    title { "#{Faker::Lorem.words(number: 1).first}" }
  end
end
