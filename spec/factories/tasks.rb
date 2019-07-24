FactoryBot.define do
  factory :task do
    description { Faker::Lorem.sentence }
    done { [false, true][0] }
    story { build(:story) }

    trait :pending do
      done { false }
    end

    trait :done do
      done { true }
    end
  end
end
