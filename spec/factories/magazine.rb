FactoryBot.define do
  factory :magazine do
    sequence(:name) { |n| "magazine_#{n}" }

    transient do
      qualities_count 5
    end

    trait :with_qualities do
      after(:stub) do |object, evaluator|
        object.stub(:qualities).and_return FactoryGirl.create_list(:category, evaluator.qualities_count)
      end
      after(:create) do |object, evaluator|
        object.qualities << create_list(:category, evaluator.qualities_count)
      end
    end
  end
end
