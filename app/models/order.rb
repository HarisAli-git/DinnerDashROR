# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :user
  validates :status, presence: true
end
