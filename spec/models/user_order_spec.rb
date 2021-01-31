require 'rails_helper'

RSpec.describe UserOrder, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @user_order = FactoryBot.build(:user_order, user_id: user.id, item_id: item.id)
  end

  describe '商品配送先登録' do
    context '商品配送先登録がうまくできる場合' do
      it 'postal_code, area-id, city, house_number, building_name, phone_number, tokenが存在すれば登録できる' do
        expect(@user_order).to be_valid
      end

      it 'postal_code, area-id, city, house_number, phone_number, tokenが存在すれば登録できる' do
        @user_order.building_name = ''
        expect(@user_order).to be_valid
      end
    end

    context '商品配送先登録がうまくできない場合' do
      it 'postal_codeが空だと登録できない' do
        @user_order.postal_code = ''
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeに"-"がないと登録できない' do
        @user_order.postal_code = '1234567'
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include('Postal code is invalid')
      end

      it 'area_idが空だと登録できない' do
        @user_order.area_id = ''
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Area can't be blank")
      end

      it 'area_idが0では登録できない' do
        @user_order.area_id = '0'
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Area must be other than 0")
      end

      it 'cityが空だと登録できない' do
        @user_order.city = ''
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("City can't be blank")
      end

      it 'house_numberが空だと登録できない' do
        @user_order.house_number = ''
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("House number can't be blank")
      end

      it 'phone_numberが空だと登録できない' do
        @user_order.phone_number = ''
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが12桁以上だと登録できない' do
        @user_order.phone_number = '090123456789'
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include('Phone number is too long (maximum is 11 characters)')
      end

      it 'phone_numberに"-"があると登録できない' do
        @user_order.phone_number = '090-1234-5678'
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include('Phone number is not a number')
      end

      it 'tokenが空だと登録できない' do
        @user_order.token = ''
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Token can't be blank")
      end

      it 'user_idが紐づいていない場合は登録できない' do
        @user_order.user_id = nil
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが紐づいていない場合は登録できない' do
        @user_order.item_id = nil
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
