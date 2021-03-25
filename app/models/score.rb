class Score < ApplicationRecord
  belongs_to :level

  validates_presence_of %i[name milliseconds]

  validates_numericality_of :milliseconds, greater_than: 0

  validates_length_of :name, minimum: 3, maximum: 20

  def as_json(options = {})
    super(only: %i[name milliseconds], **options)
  end

  def ranking
    Score.where('milliseconds <= ? AND level_id = ?', milliseconds, level_id).count
  end
end
