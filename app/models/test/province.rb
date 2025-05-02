class Province < ApplicationRecord
    # Associations
    has_many :addresses
  
    # Validations
    validates :name, :tax_rate, presence: true
  end
  