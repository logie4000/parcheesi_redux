FactoryBot.define do
  factory :track do
    ordinal { Faker::Number.between(from: 1, to: 30) }
  end
end
