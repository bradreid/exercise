FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "magazine_#{n}" }
  end
end
