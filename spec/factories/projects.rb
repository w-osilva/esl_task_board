FactoryBot.define do
  factory :project do
    name { Faker::Commerce.product_name }
    manager { build(:user) }
  end
end
