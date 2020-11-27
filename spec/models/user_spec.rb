require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    describe 'ユーザー新規登録' do
      context '新規登録がうまくいくとき' do
        it '全ての項目の入力が存在すれば登録できること' do
          expect(@user).to be_valid
        end

        it 'passwordが6文字以上であれば登録できること' do
          @user.password = '111aaa'
          @user.password_confirmation = '111aaa'
          expect(@user).to be_valid
        end
      end

      context '新規登録がうまくいかないとき' do
        it 'nicknameが空では登録できないこと' do
          @user.nickname = nil
          @user.valid?
          expect(@user.errors.full_messages).to include('ニックネームを入力してください')
        end

        it 'emailが空では登録できないこと' do
          @user.email = nil
          @user.valid?
          expect(@user.errors.full_messages).to include('Eメールを入力してください')
        end

        it '重複したemailが存在する場合登録できないこと' do
          @user.save
          another_user = FactoryBot.build(:user, email: @user.email)
          another_user.valid?
          expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
        end

        it 'emailに＠が含まれていなければ登録できないこと' do
          @user.email = 'sample.com'
          @user.valid?
          expect(@user.errors.full_messages).to include('Eメールは不正な値です')
        end

        it 'passwordが空では登録できないこと' do
          @user.password = nil
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワードを入力してください')
        end

        it 'passwordが5文字以下であれば登録できないこと' do
          @user.password = '12345'
          @user.password_confirmation = '12345'
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
        end

        it 'passwordが数字だけでは登録できないこと' do
          @user.password = '123456'
          @user.password_confirmation = '123456'
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワードは半角英数字混合で入力してください')
        end

        it 'passwordが英字だけでは登録できないこと' do
          @user.password = 'abcdef'
          @user.password_confirmation = 'abcdef'
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワードは半角英数字混合で入力してください')
        end

        it 'passwordが2回入力しないと登録できないこと' do
          @user.password = '111aaa'
          @user.password_confirmation = ''
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
        end

        it 'passwordとpassword_confirmationが不一致では登録できないこと' do
          @user.password = '123456'
          @user.password_confirmation = '1234567'
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
        end

        it 'ユーザー本名は名字が空では登録できないこと' do
          @user.last_name = nil
          @user.valid?
          expect(@user.errors.full_messages).to include('名字を入力してください')
        end

        it 'ユーザー本名は名前が空では登録できないこと' do
          @user.first_name = nil
          @user.valid?
          expect(@user.errors.full_messages).to include('名前を入力してください')
        end

        it 'ユーザー本名の名字は全角でないと登録できないこと' do
          @user.last_name = 'abc123'
          @user.valid?
          expect(@user.errors.full_messages).to include('名字は全角で入力してください')
        end

        it 'ユーザー本名の名前は全角でないと登録できないこと' do
          @user.first_name = 'abc123'
          @user.valid?
          expect(@user.errors.full_messages).to include('名前は全角で入力してください')
        end

        it 'ユーザー本名の名字のフリガナが空では登録できないこと' do
          @user.last_name_kana = nil
          @user.valid?
          expect(@user.errors.full_messages).to include('名字のフリガナを入力してください')
        end

        it 'ユーザー本名の名前のフリガナが空では登録できないこと' do
          @user.first_name_kana = nil
          @user.valid?
          expect(@user.errors.full_messages).to include('名前のフリガナを入力してください')
        end

        it 'ユーザー本名の名字のフリガナは全角カナでないと登録できないこと' do
          @user.last_name_kana = 'やまだ'
          @user.valid?
          expect(@user.errors.full_messages).to include('名字のフリガナは全角カタカナで入力してください')
        end

        it 'ユーザー本名の名前のフリガナは全角カナでないと登録できないこと' do
          @user.first_name_kana = 'やまだ'
          @user.valid?
          expect(@user.errors.full_messages).to include('名前のフリガナは全角カタカナで入力してください')
        end

        it '生年月日が空では登録できないこと' do
          @user.birthday = nil
          @user.valid?
          expect(@user.errors.full_messages).to include('生年月日を入力してください')
        end
      end
    end
  end
end
