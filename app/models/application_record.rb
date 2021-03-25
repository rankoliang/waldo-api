class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  private

  def url_helpers
    @url_helpers ||= Rails.application.routes.url_helpers
  end

  delegate :rails_blob_path, to: :url_helpers
end
