FactoryBot.define do
  factory :customer do
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.cell_phone }
  end
end