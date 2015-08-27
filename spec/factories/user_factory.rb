FactoryGirl.define do

  factory :resident do
    community
    first_name "Gene"
    last_name "Simmons"
    birthdate "1959/08/25"
    gender "male"

    factory :resident_with_user do
      after(:create) do |new_resident|
        FactoryGirl.create(:user, resident: new_resident)
      end
    end
  end

  factory :user  do
    sequence(:email) { |n| "user#{n}@example.com" }
    password "password"
    password_confirmation "password"
    resident
  end

  factory :assessor do
    association :resident, factory: :resident_with_user, first_name: "Adam", last_name: "Assessor"
    factory :assessor_with_community do
      after(:create) do |new_assessor|
        community = FactoryGirl.create(:community, name: "Shangri La")
        community.assessors << new_assessor
      end
    end
  end

end
