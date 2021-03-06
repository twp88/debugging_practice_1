require_relative "blackjack/hand"

class Blackjack
  def initialize(hands)
    @hands = hands
  end

  def play_move(move)
    raise "Invalid move" unless valid_move?(move)
    raise "Game is over" if winner

    next_hand.send(move)
  end

  def winner
    return nil if not game_over?

    hands
      .select(&:standing?)
      .reject(&:bust?)
      .sort { |hand_1, hand_2| hand_2.score <=> hand_1.score }
      .first
  end

  def game_over?
    hands.all? { |hand| hand.standing? || hand.bust? }
  end

  def valid_move?(move)
    [:hit, :stand].include?(move)
  end

  private

  attr_reader :hands

  def next_hand
    hands
      .reject(&:standing?)
      .reject(&:bust?)
      .sort { |hand_1, hand_2|
        hand_1.card_list.count <=> hand_2.card_list.count
      }.first
  end
end
