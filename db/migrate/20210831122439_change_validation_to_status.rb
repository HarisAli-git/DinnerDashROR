# frozen_string_literal: true

class ChangeValidationToStatus < ActiveRecord::Migration[6.1]
  def change
    change_column :orders, :status, :integer, default: 1, null: false
  end
end
