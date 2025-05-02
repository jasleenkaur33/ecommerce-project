class OrderItem < ApplicationRecord
    # Associations
    belongs_to :order
    belongs_to :product
  
    # Validations
    validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  end
  