# frozen_string_literal: true

class AddValidationToPrice < ActiveRecord::Migration[6.1]
  def change
    change_column :items, :price, :integer, default: 0, null: false
  end
end
