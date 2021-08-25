class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :username
      t.string :email, null: false
      t.string :pass, null: false, limit: 8 # By default SQL String limit 255 character
      t.boolean :is_Admin, default: false
      t.index :email
      t.timestamps
    end
  end
end
