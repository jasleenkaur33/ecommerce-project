class Province < ApplicationRecord
    has_many :addresses
  
    # Validations
    validates :name, :tax_rate, presence: true
end
