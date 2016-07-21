class Order < ApplicationRecord
  belongs_to :status
  has_many :order_items
  before_create :set_order_status
  before_save :update_subtotal

  def subtotal
    order_items.collect { |items| items.valid? ? {items.quantity * items.unit_price} : 0  }
  end

  private

  def set_order_status
    self.order_status_id = 1
  end

  def update_total
    self[:subtotal] = subtotal
  end
end
