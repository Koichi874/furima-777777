FactoryBot.define do
  factory :item do
    name             { Faker::Food.fruits }
    description      { '商品の説明' }
    category_id      { 1 }
    condition_id     { 1 }
    shipping_cost_id { 1 }
    area_id          { 1 }
    time_to_ship_id  { 1 }
    price            { Faker::Number.within(range: 300..9_999_999) }
    user_id          { 1 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/apple-touch-icon.png'), filename: 'apple-touch-icon.png')
    end
  end
end
