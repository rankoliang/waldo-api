class Level < ApplicationRecord
  has_many :search_areas
  has_many :characters, through: :search_areas
  has_many :scores
  has_one_attached :image

  def as_json(thumbnail: false, **options)
    options = options.merge(only: %i[id title])

    if cached_image_attached?
      if thumbnail
        super(**options).merge(image_path: image_thumbnail_path)
      else
        super(methods: [:image_path], **options)
      end
    else
      super(**options)
    end
  end

  def image_path
    Rails.cache.fetch([self, 'image_path'], expires_in: ActiveStorage.service_urls_expire_in) do
      rails_blob_path(image, only_path: true) if cached_image_attached?
    end
  end

  def image_thumbnail_path
    Rails.cache.fetch([self, 'image_thumbnail_path'], expires_in: ActiveStorage.service_urls_expire_in) do
      thumbnail = image.variant(gravity: 'center', crop: '800x600+0+0').processed

      rails_representation_url(thumbnail, only_path: true)
    end
  end

  def cached_image_attached?
    Rails.cache.fetch([self, 'image_attached?']) do
      image.attached?
    end
  end

  def self.cached(id)
    Rails.cache.fetch(['level', id], expires_in: ActiveStorage.service_urls_expire_in) do
      Level.includes(:search_areas,
                     characters: [avatar_attachment: :blob],
                     image_attachment: :blob)
           .find(id)
    end
  end
end
