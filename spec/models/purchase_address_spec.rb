require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '#create' do
    before do
      @purchase_address = FactoryBot.build(:purchase_address)
    end

    describe '商品購入処理' do
      context '商品購入処理がうまくいくとき' do
        it '全ての項目の入力が存在すれば購入できること' do
          expect(@purchase_address).to be_valid
        end

        it '建物名が空でも購入できること' do
          @purchase_address.building_name = nil
          expect(@purchase_address).to be_valid
        end
      end

      context '商品購入処理がうまくいかないとき' do
        it 'tokenが空では購入できないこと' do
          @purchase_address.token = nil
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("クレジットカード情報を入力してください")
        end

        it '郵便番号が空では購入できないこと' do
          @purchase_address.postal_code = nil
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("郵便番号を入力してください")
        end

        it '郵便番号に-がないと購入できないこと' do
          @purchase_address.postal_code = '1234567'
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include('郵便番号は-を入れてください')
        end

        it '都道府県を選択していないと登録できないこと' do
          @purchase_address.prefecture_id = 0
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include('都道府県を選択してください')
        end

        it '市区町村が空では購入できないこと' do
          @purchase_address.municipality = ''
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("市区町村を入力してください")
        end

        it '番地が空では購入できないこと' do
          @purchase_address.house_number = ''
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("番地を入力してください")
        end

        it '電話番号が空では購入できないこと' do
          @purchase_address.phone_number = nil
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("電話番号を入力してください")
        end

        it '電話番号に-があると購入できないこと' do
          @purchase_address.phone_number = '090-123-456'
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include('電話番号は半角数字だけで入力してください')
        end

        it '電話番号が11桁以内でないと購入できないこと' do
          @purchase_address.phone_number = '090123456789'
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include('電話番号は半角数字だけで入力してください')
        end
      end
    end
  end
end
