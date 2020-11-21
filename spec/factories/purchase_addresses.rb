FactoryBot.define do
  factory :purchase_address do
    token { 'tok_abcdefghijk00000000000000000' }
    postal_code { '123-4567' }
    prefecture_id { 1 }
    municipality { '横浜市緑区' }
    house_number { '青山1-1-1' }
    phone_number { '09012345678' }
  end
end
