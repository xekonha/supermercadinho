class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  CATEGORY = %w(açougue bazar bebidas congelados frios higiene hortifruti leite-derivados limpeza matinais mercearia)
  validates :name, :unit, :total_quantity, :price, :category, presence: true
end
