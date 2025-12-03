class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Rails 8 ENUM syntax
  enum :role, { customer: 0, agent: 1, admin: 2 }

  # Associations
  has_many :tickets, dependent: :nullify
  has_many :comments, dependent: :destroy
end
