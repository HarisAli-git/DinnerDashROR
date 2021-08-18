class Order < ApplicationRecord
    has_many :line_items

    validates :status, presence: true
end
