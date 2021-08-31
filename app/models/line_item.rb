# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  validates :quantity, presence: true
  validates :item_id, presence: true
  validates :order_id, presence: true

  def total_price
    item.price.to_i * quantity.to_i
  end
end
