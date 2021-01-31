require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @order = FactoryBot.build(:order)
  end

  describe '商品購入登録' do
    context '商品購入登録がうまくできる場合' do
      it 'user_id, item_idが存在すれば登録できる' do
        expect(@order).to be_valid
      end
    end

    context '商品購入登録がうまくできない場合' do
      it 'user_idが紐づいていない場合は登録できない' do
        @order.user_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include('User must exist')
      end

      it 'item_idが紐づいていない場合は登録できない' do
        @order.item_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include('Item must exist')
      end
    end
  end
end
