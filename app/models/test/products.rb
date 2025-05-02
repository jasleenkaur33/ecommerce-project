class Product < ApplicationRecord
    # Associations
    belongs_to :category
    has_one_attached :image
    has_many :order_items, dependent: :destroy
  
    # Validations
    validates :name, :description, :price, presence: true
    validates :price, numericality: { greater_than_or_equal_to: 0 }
  
    # Scopes
    scope :on_sale, -> { where(on_sale: true) }
    scope :recent, -> { order(created_at: :desc) }
  end
  