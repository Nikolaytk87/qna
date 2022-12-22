FactoryBot.define do
  factory :answer do
    sequence(:body) { |n| "AnswerBody#{n}" }
  end

  trait :invalid do
    body { nil }
  end
end
