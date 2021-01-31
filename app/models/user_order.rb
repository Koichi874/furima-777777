class UserOrder
  include ActiveModel::Model
  attr_accessor :postal_code, :area_id, :city, :house_number, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code
    validates :area_id
    validates :city
    validates :house_number
    validates :phone_number
    validates :user_id
    validates :item_id
    validates :token
  end

  validates :area_id, numericality: { other_than: 0 }
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ }, length: { maximum: 8 }
  validates :phone_number, numericality: { only_integer: true }, format: { with: /\d+/ }, length: { maximum: 11 }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Shipping.create(order_id: order.id, postal_code: postal_code, area_id: area_id, city: city, house_number: house_number,
                    building_name: building_name, phone_number: phone_number)
  end
end
