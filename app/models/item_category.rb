class ItemCategory < ApplicationRecord
    belongs_to :item
    belongs_to :category

    validates :category_id, presence: true
    validates :item_id, presence: true
end
