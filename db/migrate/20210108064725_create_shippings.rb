class CreateShippings < ActiveRecord::Migration[6.0]
  def change
    create_table :shippings do |t|
      t.string :postal_code,      default: "", null: false
      t.integer :area_id,                null: false
      t.string :city,             default: "", null: false
      t.string :house_number,     default: "", null: false
      t.string :building_name,    default: "", null: false
      t.string :phone_number,     default: "", null: false
      t.references :order,                     null: false, foreign_key: true
      t.timestamps
    end
  end
end