require 'rails_helper'

RSpec.describe SearchArea, type: :model do
  subject(:search_area) { FactoryBot.create('search_area') }

  it { is_expected.to belong_to :character }
  it { is_expected.to belong_to :level }

  it { is_expected.to validate_inclusion_of(:shape).in_array(%w[rect]) }

  %i[shape coordinates].each do |field|
    it { is_expected.to validate_presence_of(field) }
  end

  describe '#area' do
    it 'calls SearchArea.for' do
      area_factory = class_double('SearchArea').as_stubbed_const

      expect(area_factory).to receive(:for).with(search_area)

      search_area.area
    end
  end

  describe '#found?' do
    it 'expects the area to call contains?' do
      expect(search_area.area).to receive(:contains?)

      search_area.found?(x: 0, y: 0)
    end
  end
end
