class Category < ApplicationRecord
    has_many :item_categories
    has_many :categories, :through => :item_categories

    validates :name, presence: true
end
