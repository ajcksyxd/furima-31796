class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :municipality, :house_number, :building_name, :phone_number

  POSTAL_CODE_REGEX = /\A\d{3}[-]\d{4}+\z/.freeze
  PHONE_NUMBER_REGEX = /\A\d{11}+\z/.freeze

  with_options presence: true do
    validates :postal_code, format: { with: POSTAL_CODE_REGEX, message: 'is invalid. Input correctly' }
    validates :municipality
    validates :house_number
    validates :phone_number, format: { with: PHONE_NUMBER_REGEX, message: 'is invalid. Input only number' }
  end
  validates :prefecture_id, numericality: { other_than: 0, message: 'status Select' }

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, municipality: municipality, house_number: house_number, building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end
end