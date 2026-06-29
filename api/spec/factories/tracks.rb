FactoryBot.define do
  factory :track do
    ordinal { Faker::Integer.between(from: 1, to: 30) }
  end
end
