class Address < ApplicationRecord
  belongs_to :user
  belongs_to :province
  
  has_many :orders
  
  validates :line1, :city, :province, :postal_code, presence: true

end
