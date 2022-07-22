# frozen_string_literal: true

require './lib/game'

describe Game do
  subject(:game_loop) { Game.new }

  before do
    allow(game_loop.board).to receive(:puts)
    allow(game_loop).to receive(:puts)
  end

  describe '#main_loop' do
    before do
      allow(game_loop).to receive(:game_over?).and_return(false, true)
      allow(game_loop).to receive(:player_in_check)
      allow(game_loop).to receive(:make_move)
    end
    context 'when game_over is false than true' do
      it 'returns player object once' do
        expect(game_loop).to receive(:conclude).once
        game_loop.main_loop
      end
    end
  end

  describe '#play_or_exit' do
    context "When player inputs 'exit'" do
      before do
        allow(game_loop).to receive(:gets).and_return('exit')
      end
      it 'returns #exit to game_loop' do
        expect(game_loop).to receive(:exit)
        game_loop.play_or_exit
      end
    end
  end

  describe '#play_or_exit' do
    context "When player inputs move 'a2a4'" do
      before do
        allow(game_loop).to receive(:gets).and_return('a2a4')
      end
      it "game_loop receives input 'a2a4'" do
        return_value = game_loop.play_or_exit
        expect(return_value).to eq('a2a4')
      end
    end
  end

  describe '#make_move' do
    context 'when make-move receives valid input' do
      before do
        updated_move = [[2, 1],[3, 2]]
        allow(game_loop).to receive(:verify).and_return(updated_move)
      end
      it '@board receives make_move' do
        input = 'a2a4'

        expect(game_loop.board).to receive(:make_move)
        game_loop.make_move(input)
      end
    end
  end

  # finish at verify
  describe '#verify' do

  end

  describe '#syntax_check' do
    context 'When player inputs incorrectly four times, and then correctly' do
      before do
        first = 'i7z3'
        second = 'a9b0'
        third = 'a2 b4'
        correct = 'g2h3'
        allow(game_loop).to receive(:gets).and_return(first, second, third, correct)
      end
      it 'returns error message three times' do
        message = "Input Error! \n" \
        "Use board notation to denote start & end positions.\n" \
        'Examples: a2b3, h4h3, c1c5... etc: '
        initial_incorrect = 'H1b10'
        expect(game_loop).to receive(:puts).with(message).exactly(4).times
        game_loop.syntax_check(initial_incorrect)
      end
    end
  end
end
