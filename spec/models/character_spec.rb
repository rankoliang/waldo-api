require 'rails_helper'

RSpec.describe Character, type: :model do
  it { is_expected.to belong_to :level }

  %i[name shape coordinates].each do |field|
    it { is_expected.to validate_presence_of(field) }
  end

  it { is_expected.to validate_inclusion_of(:shape).in_array(%w[poly rect circle]) }
end
