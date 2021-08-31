# frozen_string_literal: true

class Item < ApplicationRecord
  has_many :item_categories, dependent: :destroy
  has_many :categories, through: :item_categories

  has_many :line_items
  has_many :carts, through: :line_items
  has_one_attached :avatar

  validates :title, presence: true, uniqueness: true
  validates :description, length: { minimum: 20 }
  validates :price, presence: true
  validates_associated :item_categories
end
