# README

# テーブル設計

## users Table

| Column             | Type    | Options                                |
| ------------------ | ------- | -------------------------------------- |
| nickname           | string  | null: false                            |
| encrypted_password | string  | null: false                            |
| email              | string  | null: false, unique: true, index: true |
| first_name         | string  | null: false                            |
| last_name          | string  | null: false                            |
| first_name_kana    | string  | null: false                            |
| last_name_kana     | string  | null: false                            |
| birthday           | date    | null: false                            |

### Associations
-has_many: items
-has_many: orders


## items Table

| Column          | Type       | Options                                |
| --------------- | ---------- | -------------------------------------- |
| name            | string     | null: false                            |
| price           | integer    | null: false                            |
| description     | text       | null: false                            |
| user            | references | null: false, foreign_key: true         |
| category_id     | integer    | null: false                            |
| condition_id    | integer    | null: false                            |
| shipping_cost_id| integer    | null: false                            |
| area_id         | integer    | null: false                            |
| time_to_ship_id | integer    | null: false                            |

### Associations
-belongs_to: user
-has_one: order
-belongs_to_active_hash: category
-belongs_to_active_hash: condition
-belongs_to_active_hash: shipping_cost
-belongs_to_active_hash: area
-belongs_to_active_hash: time_to_ship

## orders Table
| Column          | Type       | Options                                |
| --------------- | ---------- | -------------------------------------- |
| user            | references | null: false, foreign_key: false        |
| item            | references | null: false, foreign_key: false        |

### Associations
-belongs_to: user
-belongs_to: item
-has_one: shipping

## shippings Table
| Column          | Type       | Options                                |
| --------------- | ---------- | -------------------------------------- |
| postal_code     | string     | null: false                            |
| prefecture_id   | integer    | null: false                            |
| city            | string     | null: false                            |
| house_number    | string     | null: false                            |
| building_name   | string     | null: true                             |
| phone_number    | string     | null: false                            |
| order           | references | null: false, foreign_key: true         |

### Associations
-belongs_to: order