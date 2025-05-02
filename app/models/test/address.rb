class Address < ApplicationRecord
    # Associations
    belongs_to :user
  
    # Validations
    validates :line1, :city, :province, :postal_code, presence: true
  end
  