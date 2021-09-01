# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :user
  validate :check_status

  private
    def check_status
      status in [-1..2]
    end
end
