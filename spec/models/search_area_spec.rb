require 'rails_helper'

RSpec.describe SearchArea, type: :model do
  subject(:search_area) { FactoryBot.create('search_area') }

  it { is_expected.to belong_to :character }
  it { is_expected.to belong_to :level }

  it { is_expected.to validate_inclusion_of(:shape).in_array(%w[rect]) }

  %i[shape coordinates].each do |field|
    it { is_expected.to validate_presence_of(field) }
  end

  describe '.for' do
    subject(:search_area) do
      FactoryBot.create('search_area', shape: shape, coordinates: coordinates)
    end

    let(:area) do
      described_class.for(search_area)
    end

    context 'when the shape is a rect' do
      let(:shape) { 'rect' }
      let(:coordinates) { '0,0,10,10' }

      it 'returns a RectSearchArea' do
        expect(area).to be_kind_of(RectSearchArea)
      end
    end
  end

  describe '#found?' do
    let(:specific_area) { described_class.for(search_area) }

    before(:each) do
      allow(described_class).to receive(:for).and_return(specific_area)
    end

    it 'calls SearchArea.for' do
      expect(described_class).to receive(:for).with(search_area)

      search_area.found?(x: 0, y: 0)
    end

    it 'expects the area to call contains?' do
      expect(specific_area).to receive(:contains?)

      search_area.found?(x: 0, y: 0)
    end
  end
end
