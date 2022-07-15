require './lib/game'

describe Game do
  describe '#notation' do
    subject(:game_notation) { described_class.new }
    context 'When input is b2b3' do
      it 'returns [[6, 1], [5, 1]]' do
        input = 'b2b3'
        notation = game_notation.notation(input)
        expect(notation).to eq([[6, 1], [5, 1]])

      end
    end

    subject(:game_notation) { described_class.new }
    context 'When input is g2g4' do
      it 'returns [[6, 6], [4, 6]]' do
        input = 'g2g4'
        notation = game_notation.notation(input)
        expect(notation).to eq([[6, 6], [4, 6]])

      end
    end

    context 'When input is g1h3' do
      it 'returns [[7, 6], [5, 7]]' do
        input = 'g1h3'
        notation = game_notation.notation(input)
        expect(notation).to eq([[7, 6], [5, 7]])

      end
    end
  end
end