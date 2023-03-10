FactoryBot.define do
  factory :question do
    sequence(:title) { |n| "QuestionTitle#{n}" }
    sequence(:body) { |n| "QuestionBody#{n}" }

    trait :invalid do
      title { nil }
    end
  end
end
