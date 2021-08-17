class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.date :order_date, null: false
      t.boolean :status
      t.timestamps
    end
  end
end
