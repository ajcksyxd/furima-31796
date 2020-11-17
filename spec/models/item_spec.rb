require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end

    describe '商品新規出品' do
      context '新規登録がうまくいくとき' do
        it '全ての項目の入力が存在すれば登録できること' do
          expect(@item).to be_valid
        end

        it '価格の入力が指定した範囲内であれば登録できること' do
          @item.price = 1000
          expect(@item).to be_valid
        end
      end

      context '新規登録がうまくいかないとき' do
        it '商品画像が空では登録できないこと' do
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Image can't be blank")
        end

        it '商品名が空では登録できないこと' do
          @item.name = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Name can't be blank")
        end

        it '商品の説明が空では登録できないこと' do
          @item.description = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Description can't be blank")
        end

        it 'categoryを選択していないと登録できないこと' do
          @item.category_id = 0
          @item.valid?
          expect(@item.errors.full_messages).to include('Category status Select')
        end

        it 'conditionを選択していないと登録できないこと' do
          @item.condition_id = 0
          @item.valid?
          expect(@item.errors.full_messages).to include('Condition status Select')
        end

        it 'shipping_chargeを選択していないと登録できないこと' do
          @item.shipping_charge_id = 0
          @item.valid?
          expect(@item.errors.full_messages).to include('Shipping charge status Select')
        end

        it 'prefectureを選択していないと登録できないこと' do
          @item.prefecture_id = 0
          @item.valid?
          expect(@item.errors.full_messages).to include('Prefecture status Select')
        end

        it 'days_to_shipを選択していないと登録できないこと' do
          @item.days_to_ship_id = 0
          @item.valid?
          expect(@item.errors.full_messages).to include('Days to ship status Select')
        end

        it '販売価格が空では登録できないこと' do
          @item.price = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Price can't be blank")
        end

        it '販売価格が指定の範囲外では登録できないこと' do
          @item.price = 299
          @item.valid?
          expect(@item.errors.full_messages).to include('Price is out of setting range')
        end

        it '販売価格が指定の範囲外では登録できないこと' do
          @item.price = 10_000_000
          @item.valid?
          expect(@item.errors.full_messages).to include('Price is out of setting range')
        end

        it '販売価格が半角数字でないと登録できないこと' do
          @item.price = 'abcdef'
          @item.valid?
          expect(@item.errors.full_messages).to include('Price is invalid. Input half-width characters.')
        end
      end
    end
  end
end
