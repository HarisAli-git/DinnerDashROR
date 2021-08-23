class LineItem < ApplicationRecord
    belongs_to :item
    belongs_to :cart
    belongs_to :order

    validates :quantity, presence: true
    validates :item_id, presence: true
    validates :order_id, presence: true
end
