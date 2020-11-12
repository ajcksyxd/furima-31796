# テーブル設計

## users テーブル

| Column         | Type    | Options     |
| ---------------| ------- | ----------- |
| nickname       | string  | null: false |
| email          | string  | null: false |
| password       | string  | null: false |
| name           | string  | null: false |
| name_katakana  | string  | null: false |
| birth_year     | integer | null: false |
| month_of_birth | integer | null: false |
| date_of_birth  | integer | null: false |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column           | Type       | Options          |
| ---------------- | ---------- | ---------------- |
| image            |            |                  |
| name             | text       | null: false      |
| description      | text       | null: false      |
| category         | string     | null: false      |
| condition        | string     | null: false      |
| shipping_charges | string     | null: false      |
| shipping_area    | string     | null: false      |
| days_to_ship     | string     | null: false      |
| price            | integer    | null: false      |
| user             | references | foreign_key:true |

### Association

- belongs_to :user
- has_one :purchase

## purchases テーブル

| Column     | Type       | Options          |
| ---------- | ---------- | ---------------- |
| user       | references | foreign_key:true |
| item       | references | foreign_key:true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :addresses

## addresses テーブル

| Column        | Type    | Options     |
| --------------| ------- | ----------- |
| postal_code   | string  | null: false |
| prefectures   | string  | null: false |
| municipality  | string  | null: false |
| house_number  | string  | null: false |
| building_name | string  |             |
| phone_number  | integer | null: false |

### Association

- belongs_to :purchase