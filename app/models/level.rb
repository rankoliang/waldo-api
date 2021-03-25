class Level < ApplicationRecord
  has_many :search_areas
  has_many :characters, through: :search_areas
  has_many :scores
  has_one_attached :image

  def as_json(options)
    options = options.merge(only: %i[id title])

    if image.attached?
      super(methods: [:image_path], **options)
    else
      super(**options)
    end
  end

  def image_path
    rails_blob_path(image, only_path: true) if image.attached?
  end
end
