require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#create' do
    before do
      @comment = FactoryBot.build(:comment)
    end

    describe 'コメント投稿' do
      context 'コメント投稿がうまくいくとき' do
        it 'コメント入力が存在すれば投稿できること' do
          expect(@comment).to be_valid
        end
      end

      context 'コメント投稿がうまくいかないとき' do
        it 'コメントが空では投稿できないこと' do
          @comment.text = nil
          @comment.valid?
          expect(@comment.errors.full_messages).to include('Textを入力してください')
        end

        it 'itemが紐付いていないと投稿できないこと' do
          @comment.item = nil
          @comment.valid?
          expect(@comment.errors.full_messages).to include('Itemを入力してください')
        end

        it 'userが紐付いていないと投稿できないこと' do
          @comment.user = nil
          @comment.valid?
          expect(@comment.errors.full_messages).to include('Userを入力してください')
        end
      end
    end
  end
end
