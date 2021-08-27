# frozen_string_literal: true

class AddTotalToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :total, :integer, default: 0, null: false
  end
end
