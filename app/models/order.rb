# app/models/order.rb

class Order < ApplicationRecord
  after_initialize :set_default_status, if: :new_record?

  belongs_to :user
  belongs_to :address
  has_many :order_items, dependent: :destroy

  # Enum for order status
  enum status: { pending: 0, paid: 1, shipped: 2, cancelled: 3 }

  def total_amount
    order_items.sum { |item| item.quantity * item.price }
  end

  def tax_breakdown
    province = address.province
    subtotal = total_amount

    gst = province.gst ? subtotal * (province.gst / 100) : 0
    pst = province.pst ? subtotal * (province.pst / 100) : 0
    hst = province.hst ? subtotal * (province.hst / 100) : 0

    {
      gst: gst.round(2),
      pst: pst.round(2),
      hst: hst.round(2),
      total_tax: (gst + pst + hst).round(2),
      total_price: (subtotal + gst + pst + hst).round(2)
    }
  end

  def set_default_status
    self.status ||= :pending
  end
end
