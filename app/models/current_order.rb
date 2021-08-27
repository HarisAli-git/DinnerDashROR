# frozen_string_literal: true

class CurrentOrder
  attr_accessor :line_items, :total

  def initialize(current_order)
    @line_items = current_order["items"] || {}
    current_order["details"] ||= {}
    @total = current_order["total"].to_i || 0
    @user = {}
    @status = false
  end

  def update_order(order, args)
    @line_items = order["items"] || {}
    @total = order["details"]["total"] || 0
    @status = args[:status] || true
  end

  def save_order(current_user)
    user = current_user
    new_order = user.orders.new(status: @status, total: @total)
    succ = new_order.save

    if succ
      @line_items.each do |_index, details|
        @line_item = LineItem.new(item_id: details["item"]["id"], quantity: details["quantity"],
                                  order_id: new_order.id)

        @line_item.save
        new_order.line_items.push(@line_item)
      end
    end
    succ
  end
end
