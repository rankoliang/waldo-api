require_relative '../../app/character_areas/character_area'
require_relative '../../app/character_areas/character_rect_area'

RSpec.describe CharacterArea do
  describe '.for' do
    subject(:area) { described_class.for(shape: shape, coordinates: coordinates) }

    context 'when the shape is a rect' do
      let(:shape) { 'rect' }
      let(:coordinates) { '0,0,10,10' }

      it 'returns a CharacterRectArea' do
        expect(area).to be_kind_of(CharacterRectArea)
      end
    end

    context 'when the shape is unknown' do
      let(:shape) { 'invalid' }
      let(:coordinates) { 'invalid' }

      it {
        expect do
          described_class.for(shape: shape, coordinates: coordinates)
        end.to raise_error(ArgumentError, "no character area for #{shape}")
      }
    end
  end
end
