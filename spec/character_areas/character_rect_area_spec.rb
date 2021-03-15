require_relative '../../app/character_areas/character_rect_area'

RSpec.describe CharacterRectArea do
  subject(:area) { described_class.new(coordinates) }

  let(:coordinates) { '0,0,10,10' }

  it 'parses the given coordinates' do
    expect(area.coordinates).to eq([0, 0, 10, 10])
  end

  describe '#contains?' do
    context 'when the given coordinates are in the area' do
      it { expect(area.contains?(x: 5, y: 5)).to be true }
    end

    context 'when the given coordinates are not in the area' do
      it { expect(area.contains?(x: 11, y: 11)).to be false }
    end
  end
end
