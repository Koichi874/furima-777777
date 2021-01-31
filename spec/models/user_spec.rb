require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context 'ユーザー新規登録ができる場合' do
      it 'nickname, email, password, password_confirmation, first_name, last_name, first_name_kana, last_name_kana, birthday が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context 'ユーザー新規登録ができない場合' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '同じemailがすでに登録されている場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailに＠がない場合は登録できない' do
        @user.email = 'email.gmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空の場合は登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが６文字未満の場合は登録できない' do
        @user.password = 'abc12'
        @user.password_confirmation = 'abc12'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordは入力したがpassword_confirmationが空の場合は登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'first_nameが空の場合は登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'first_nameが全角以外の場合は登録できない' do
        @user.first_name = 'mariko'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name 全角(漢字・ひらがな・カタカナ)を使用してください')
      end
      it 'last_nameが空の場合は登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'last_nameが全角以外の場合は登録できない' do
        @user.last_name = 'yamamoto'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name 全角(漢字・ひらがな・カタカナ)を使用してください')
      end
      it 'first_name_kanaが空の場合は登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'last_name_kanaが空の場合は登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'first_name_kanaが全角カナ以外の場合は登録できない' do
        @user.first_name_kana = 'ﾏﾘｺ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana 全角カタカナを使用してください')
      end
      it 'last_name_kanaが全角カナ以外の場合は登録できない' do
        @user.last_name_kana = 'ﾔﾏﾓﾄ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana 全角カタカナを使用してください')
      end
      it 'birthdayが空の場合は登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
