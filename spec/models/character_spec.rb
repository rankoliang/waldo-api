require 'rails_helper'

RSpec.describe Character, type: :model do
  subject(:character) { FactoryBot.create('character') }

  it { is_expected.to have_many :search_areas }
  it { is_expected.to have_many(:levels).through(:search_areas) }

  it { is_expected.to have_one_attached :avatar }

  it { is_expected.to validate_presence_of :name }
end
