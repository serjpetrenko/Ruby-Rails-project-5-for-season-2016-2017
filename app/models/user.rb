class User < ApplicationRecord
  validates :phone, numericality: { greater_than: 6, allow_nil: true }
  validates :first_name, :last_name, :email, :password, presence: true
  has_many  :orders
  has_secure_password
end
