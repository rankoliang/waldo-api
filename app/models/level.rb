class Level < ApplicationRecord
  has_many :characters
  has_many :scores
  has_one_attached :image

  def as_json(options)
    options = options.merge(root: true, only: [:title])
    if image.attached?
      super(methods: [:image_path], **options)
    else
      super(**options)
    end
  end

  def image_path
    Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true) if image.attached?
  end
end
