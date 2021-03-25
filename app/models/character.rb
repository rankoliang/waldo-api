require_relative '../character_areas/character_area'

class Character < ApplicationRecord
  has_many :search_areas
  has_many :levels, through: :search_areas

  has_one_attached :avatar

  validates_presence_of %i[name]

  def as_json(options = {})
    super(only: %i[id name], methods: [:avatar_path], **options)
  end

  def avatar_path
    rails_blob_path(avatar, only_path: true) if avatar.attached?
  end
end
