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
  deck.delete(card[0])
  return card
end

def winner?(hand1, hand2)
  if bust?(hand1)
    puts "Computer wins #{hand2}"
  end

  if hand1 > hand2
    puts "Player 1 won #{hand1}"
  else
    puts "Computer won #{hand2}"
  end
end

def bust?(score)
  if score > 21
    return true
  else
    return false
  end
end

def hand_value(hand)
  score = hand.to_h.values # is an array
  number_aces = (score.select { |card| card == "ace" }).length
  hand_without_aces = score.select { |card| card != "ace" }
  score_without_aces = hand_without_aces.inject(0) { |sum, card| sum += card }
  if number_aces > 0
    ace_value(score_without_aces, number_aces)
  else
    score_without_aces
  end
end

def ace_value(score, ace_count)
  ace_count.times do 
    if (score + 11) > 21
      score += 1
    else
      score += 11
    end
  end
  score
end



def black_jack
  deck = initialize_deck
  player_hand = []
  computer_hand = []
  2.times { player_hand << deal(deck) }
  2.times { computer_hand << deal(deck) }
  player_score = hand_value(player_hand)
  computer_score = hand_value(computer_hand)

  begin
    puts "you have #{player_hand} which adds to #{player_score}"
    puts "Computer has #{computer_hand} which adds to #{computer_score}"
    # player decides to hit or stay

    if bust?(player_score)
      return puts "Sorry you lost"
    else
      puts "would you like to hit or stay?"  
      choice = gets.chomp
    end

    if choice == "hit"
      player_hand << deal(deck)
      player_score = hand_value(player_hand)
    end

    # computer decides to hit or stay
    if computer_score < 17
      computer_hand << deal(deck)
      computer_score = hand_value(computer_hand)
    else 
      # randomly decide to hit or stay
      hit_or_stay = (0..1).to_a.sample
      if hit_or_stay == 1
        computer_hand << deal(deck)
        computer_score = hand_value(computer_hand)
      end
    end
  end until choice == "stay" || (bust? computer_score)
  winner?(player_score, computer_score)
end

black_jack
  

