FactoryBot.define do
  factory :user do
    nickname              { 'tarou' }
    email                 { 'sample@gmail.com' }
    password              { '111aaa' }
    password_confirmation { '111aaa' }
    last_name             { '山田' }
    last_name_kana        { 'ヤマダ' }
    first_name            { '太郎' }
    first_name_kana       { 'タロウ' }
    birthday              { '2000-01-01' }
  end
end
