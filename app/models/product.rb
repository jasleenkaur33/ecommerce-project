class Product < ApplicationRecord
  belongs_to :category

  has_one_attached :image
  has_many :order_items, dependent: :destroy
  has_many :cart_items, dependent: :destroy


  # Validations
  validates :name, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  # Scope to filter products that are on sale
  scope :on_sale, -> { where(on_sale: true) }

  # Scope to filter products added in the last 3 days (new)
  scope :new_products, -> { where("created_at >= ?", 3.days.ago) }

  # Scope to filter products updated in the last 3 days but exclude newly added products
  scope :recently_updated, -> { where("updated_at >= ?", 3.days.ago).where.not("created_at >= ?", 3.days.ago) }


end
