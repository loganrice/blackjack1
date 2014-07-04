require 'pry'

def initialize_deck
  suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
  ranks = [2, 3, 4, 5, 6, 7, 8, 9, 10, "ace", "jack", "queen", "king"]
  deck = {}

  suits.each do |suit|
    ranks.each do |rank|
      key = (suit + rank.to_s).to_sym
      key = "#{rank} of #{suit}".to_sym
      deck[key] = rank 
    end
  end
  return deck 
end

puts initialize_deck