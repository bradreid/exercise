FactoryBot.define do
  factory :subscriber do
    sequence(:name) { |n| "subscriber_#{n}" }

    transient do
      interests_count 5
    end

    trait :with_interests do
      after(:stub) do |object, evaluator|
        object.stub(:interests).and_return FactoryGirl.create_list(:category, evaluator.interests_count)
      end
      after(:create) do |object, evaluator|
        object.interests << create_list(:category, evaluator.interests_count)
      end
    end
  end
end
