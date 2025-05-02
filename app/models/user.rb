class User < ApplicationRecord
  # Devise modules (if using Devise for authentication)
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :trackable

  # Associations
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy
  
  # Validations
  validates :email, presence: true, uniqueness: true
  def admin?
    admin
  end
  
end
