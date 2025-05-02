class CanadianCity < ApplicationRecord
    validates :name, presence: true
    validates :province, presence: true
  end