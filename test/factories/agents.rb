FactoryBot.define do
  factory :agent do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    agent_code { Faker::Number.number(digits: 6) }
  end
end