require 'rails_helper'

RSpec.describe Character, type: :model do
  subject(:character) { FactoryBot.create('character') }

  it { is_expected.to belong_to :level }
  it { is_expected.to have_many :search_areas }

  it { is_expected.to have_one_attached :avatar }

  %i[name shape coordinates].each do |field|
    it { is_expected.to validate_presence_of(field) }
  end

  it { is_expected.to validate_inclusion_of(:shape).in_array(%w[poly rect circle]) }

  describe '#area' do
    it 'calls CharacterArea.for' do
      area_factory = class_double('CharacterArea').as_stubbed_const

      expect(area_factory).to receive(:for).with(shape: character.shape, coordinates: character.coordinates)

      character.area
    end
  end

  describe '#found?' do
    it 'expects the area to call contains?' do
      expect(character.area).to receive(:contains?)
      character.found?(x: 0, y: 0)
    end
  end
end
