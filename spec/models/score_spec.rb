require 'rails_helper'

RSpec.describe Score, type: :model do
  it { is_expected.to belong_to :level }

  %i[name milliseconds].each do |field|
    it { is_expected.to validate_presence_of(field) }
  end

  it { is_expected.to validate_numericality_of(:milliseconds).is_greater_than(0) }

  it { is_expected.to validate_length_of(:name).is_at_most(20) }
end
