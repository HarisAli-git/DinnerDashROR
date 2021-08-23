class AddCartRefToLineItems < ActiveRecord::Migration[6.1]
  def change
    add_reference :line_items, :cart, null: true, foreign_key: true
  end
end
