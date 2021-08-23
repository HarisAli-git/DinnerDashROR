class Cart < ApplicationRecord
    belongs_to :user

    has_many :line_items
    has_many :items, :through => :line_items

    validates :user_id, presence: true

    def add_items(items_params)
        current_item = cart_items.find_by(item_id: product_params[:item][:item_id])
        if current_item
          current_item.quantity += product_params[:product][:quantity].to_i
        current_item.save
        else
        new_item = cart_items.create(product_id: product_params[:product][:product_id],
          quantity: product_params[:product][:quantity],
          cart_id: self.id)
        end
       new_item
    end

end
