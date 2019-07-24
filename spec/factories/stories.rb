FactoryBot.define do
  factory :story do
    name { Faker::Lorem.sentence }
    status { [:pending, :started, :delivered, :accepted][0] }
    description { Faker::Lorem.paragraphs }
    started_at { Time.now }
    finished_at { started_at + 1.hour }
    deadline { Time.now + 1.day }
    points { [1, 2, 3, 5, 8, 13].sample }
    requester { build(:user) }
    owner { build(:user) }
    project { build(:project) }

    trait :pending do
      status { :pending }
    end

    trait :started do
      status { :started }
    end

    trait :delivered do
      status { :delivered }
    end

    trait :accepted do
      status { :accepted }
    end
  end
end
