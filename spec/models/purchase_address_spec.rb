require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '#create' do
    before do
      @purchase_address = FactoryBot.build(:purchase_address)
    end

    describe '商品購入処理' do
      context '商品購入処理がうまくいくとき' do
        it '建物名以外の全ての項目の入力が存在すれば購入できること' do
          expect(@purchase_address).to be_valid
        end
      end

      context '商品購入処理がうまくいかないとき' do
        it 'tokenが空では購入できないこと' do
          @purchase_address.token = nil
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
        end

        it '郵便番号が空では購入できないこと' do
          @purchase_address.postal_code = nil
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("Postal code can't be blank")
        end

        it '郵便番号に-がないと購入できないこと' do
          @purchase_address.postal_code = '1234567'
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include('Postal code is invalid. Input correctly')
        end

        it '都道府県を選択していないと登録できないこと' do
          @purchase_address.prefecture_id = 0
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include('Prefecture status Select')
        end

        it '市区町村が空では購入できないこと' do
          @purchase_address.municipality = ''
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("Municipality can't be blank")
        end

        it '番地が空では購入できないこと' do
          @purchase_address.house_number = ''
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("House number can't be blank")
        end

        it '電話番号が空では購入できないこと' do
          @purchase_address.phone_number = nil
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("Phone number can't be blank")
        end

        it '電話番号に-があると購入できないこと' do
          @purchase_address.phone_number = '090-123-456'
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include('Phone number is invalid. Input only number')
        end

        it '電話番号が11桁以内でないと購入できないこと' do
          @purchase_address.phone_number = '090123456789'
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include('Phone number is invalid. Input only number')
        end
      end
    end
  end
end
