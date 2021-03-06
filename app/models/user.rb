class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  NAME_REGEX = /\A[ぁ-んァ-ン一-龥]+\z/.freeze
  NAME_KANA_REGEX = /\A[ァ-ヶー－]+\z/.freeze
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z+\d]+\z/i.freeze

  with_options presence: true do
    validates :nickname
    validates :last_name, format: { with: NAME_REGEX, message: 'は全角で入力してください' }
    validates :first_name, format: { with: NAME_REGEX, message: 'は全角で入力してください' }
    validates :last_name_kana, format: { with: NAME_KANA_REGEX, message: 'は全角カタカナで入力してください' }
    validates :first_name_kana, format:  { with: NAME_KANA_REGEX, message: 'は全角カタカナで入力してください' }
    validates :birthday
  end
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'は半角英数字混合で入力してください' }

  has_many :items
  has_many :purchases
  has_many :comments
end
