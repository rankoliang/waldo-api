class Score < ApplicationRecord
  belongs_to :level

  validates_presence_of %i[name milliseconds]

  validates_numericality_of :milliseconds, greater_than: 0

  validates_length_of :name, maximum: 20

  def as_json(options = {})
    super(only: %i[name milliseconds], **options)
  end
end
