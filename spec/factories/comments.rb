FactoryBot.define do
  factory :comment do
    text { '値下げしてください' }
    association :user
    association :item
  end
end