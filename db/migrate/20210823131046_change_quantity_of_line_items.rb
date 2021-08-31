# frozen_string_literal: true

class ChangeQuantityOfLineItems < ActiveRecord::Migration[6.1]
  def change
    change_column_default :line_items, :quantity, 1
  end
end
