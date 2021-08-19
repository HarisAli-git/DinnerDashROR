class Item < ApplicationRecord
    has_many :item_categories
    has_many :categories, :through => :item_categories

    has_many :line_items
    has_many :carts, :through => :line_items

    validates :title, presence: true, null: false, unique: true
    validates :description, null: true, length: {minimum: 20}
    validates :price, presence: true
    validates_associated :item_categories
end
