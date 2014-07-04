require 'pry'

def initialize_deck
  suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
  ranks = [2, 3, 4, 5, 6, 7, 8, 9, 10, "ace", "jack", "queen", "king"]
  deck = {}

  suits.each do |suit|
    ranks.each do |rank|
      key = "#{rank} of #{suit}"
      if rank.is_a? String and rank != "ace"
        deck[key] = 10
      else
        deck[key] = rank 
      end
    end
  end

  return deck 
end

def deal(deck)
  card = deck.to_a.sample
end

def black_jack
  deck = initialize_deck
  player_hand = []
  computer_hand = []
  2.times { player_hand << deal(deck) }
  2.times { computer_hand << deal(deck) }
  binding.pry
end

black_jack
  

