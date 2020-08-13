FactoryBot.define do

  factory :user do
    email      { Faker::Internet.email }
    password   {"92345678"}
    nickname   {"aas"}
    id         {1}
  end
end