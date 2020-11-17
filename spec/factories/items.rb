FactoryBot.define do
  factory :item do
    name               { '美容室' }
    description        { '広いです' }
    category_id        { 1 }
    condition_id       { 1 }
    shipping_charge_id { 1 }
    prefecture_id      { 1 }
    days_to_ship_id    { 1 }
    price              { 1000 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
