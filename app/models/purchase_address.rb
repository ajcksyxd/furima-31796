class PurchaseAddress
  include ActiveModel: :Model
  attr_accessor :postal_code, :prefecture, :municipality, :house_namber, :building_name, :phone_number

  POSTAL_CODE_REGEX = /\A\d{3}[-]\d{4}+\z/.freeze
  PHONE_NUMBER_REGEX = /\A\d{11}+\z/.freeze

  with_options presence: true do
    validates :postal_code, format: { with: POSTAL_CODE_REGEX, message: 'is invalid. Input correctly' }
    validates :prefecture, numericality: { other_than: 0, message: 'status Select' }
    validates :manicipality
    validates :houde_number
    validates :phone_number, format: { with: PHONE_NUMBER_REGEX, message: 'is invalid. Input only number' }
  end

  def save
    user = User.create(nickname: nickname, :email email, encrypted_password: encrypted_password, last_name: last_name, first_name: first_name, last_name_kana: last_name_kana, first_name_kana: first_name_kana, birthday: birthday)
    item = Item.create(name: name, description: description, category: category, condition: condition, shipping_charge: shipping_charge, prefecture: prefecture, days_to_ship: days_to_ship, price: price)
    purchase = Purchase.create(user_id: user.id, item_id: item.id)
    Address.create(postal_code: postal_code, prefecture: prefecture, municipality: municipality, house_number: house_number, building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end
end