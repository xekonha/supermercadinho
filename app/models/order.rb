class Order < ApplicationRecord
  belongs_to :product
  belongs_to :user
  validates :completed, presence: true
end
