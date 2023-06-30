class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :recipes, through: :recipe_foods, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :measurement_unit, presence: true
  validates :price, presence: true
end
