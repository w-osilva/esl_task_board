FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { "#{name.parameterize.underscore}@taskboard.net" }
    password { "P@55w0rd" }
    encrypted_password {""}
    role { [:admin, :user, :guest].sample }

    trait :admin do
      role { :admin }
    end

    trait :user do
      role { :user }
    end

    trait :guest do
      role { :guest }
    end
  end
end
