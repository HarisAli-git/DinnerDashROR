# frozen_string_literal: true

class Cart < ApplicationRecord
  attr_reader :cart_data

  belongs_to :user

  has_many :line_items
  has_many :items, through: :line_items

  validates :user_id, presence: true

  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items

  def sub_total
    sum = 0
    line_items.each do |item|
      sum += item.total_price
    end
    sum
  end

  def initialize(cart_data)
    @cart_data = cart_data || {}
  end

  def increment(item_id)
    @cart_data[item_id] ||= 0
    @cart_data[item_id] += 1
  end
end
