class Level < ApplicationRecord
  has_many :characters
  has_many :scores
end
