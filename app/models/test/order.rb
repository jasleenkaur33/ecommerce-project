class Order < ApplicationRecord
    # Associations
    belongs_to :user
    has_many :order_items, dependent: :destroy
  
    # Enum for order status
    enum status: { pending: 0, paid: 1, shipped: 2, cancelled: 3 }
  
    # Callbacks
    before_save :calculate_total
  
    private
  
    def calculate_total
      self.total_price = order_items.sum { |item| item.price * item.quantity }
    end
  end
  