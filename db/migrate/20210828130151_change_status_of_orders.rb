# frozen_string_literal: true

class ChangeStatusOfOrders < ActiveRecord::Migration[6.1]
  def change
    change_column :orders, :status, :integer
  end
end
