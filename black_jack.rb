class Deck
  attr_reader :cards

  SUITS = ["Hearts", "Diamonds", "Clubs", "Spades"]
  RANKS = [2, 3, 4, 5, 6, 7, 8, 9, 10, "ace", "jack", "queen", "king"]
  
  def initialize
    @cards = build_cards
  end

  def build_cards
    cards_value_pairs = SUITS.product(RANKS)
    deck_of_cards = {}
    cards_value_pairs.each do |card_value|
      suit = card_value[0]
      rank = card_value[1]
      value = card_value_helper(card_value[1])
      deck_of_cards["#{rank} of #{suit}"] = value 
    end
    deck_of_cards
  end

  def card_value_helper(card_rank)
    # this method helps determin
    if card_rank.is_a? String and card_rank != "ace"
      10
    else
      card_rank
    end
  end
end

class Dealer
  def initialize
    @dealers_deck = Deck.new.cards
    shuffle
  end

  def shuffle
    @dealers_deck = Hash[@dealers_deck.to_a.sample(@dealers_deck.length)]
  end

  def deal
    card = @dealers_deck.to_a.sample
    @dealers_deck.delete(card[0])
    return card 
  end
end

class BlackJackGameEngine
  attr_reader :player_hand, :computer_hand, :player_score

  def initialize
    setup
    play
    again?
  end

  def again?
    answer = "y"
    while answer == "y" 
      puts "would you like to play again?"
      answer = gets.chomp
      answer = answer[0].downcase
      if answer == "y"
        BlackJackGameEngine.new
      end
    end 
  end

  def setup
    @a_dealer = Dealer.new
    @player_hand = []
    @computer_hand = []
    2.times { hit(@player_hand) }
    2.times { hit(@computer_hand) }
    @player_score = hand_value(@player_hand)
    @computer_score = hand_value(@computer_hand)
  end

  def hit(player)
      player << @a_dealer.deal
  end

  def hand_value(hand)
    card_ranks = hand.to_h.values
    number_aces = (card_ranks.select { |card| card == "ace" }).length
    hand_without_aces = card_ranks.select { |card| card != "ace" }
    score_without_aces = hand_without_aces.inject(0) { |sum, card| sum += card }
    if number_aces > 0
      ace_value_helper(score_without_aces, number_aces)
    else
      score_without_aces
    end
  end

  def ace_value_helper(partial_score, ace_count)
    ace_count.times do 
      if (partial_score + 11) > 21
        partial_score += 1
      else
        partial_score += 11
      end
    end
    partial_score
  end

  def bust?(a_score)
    if a_score > 21
      return true
    else
      return false
    end
  end

  def play
    welcome_message
    begin
      break if (bust? @player_score) || (bust? @computer_score)
      break if @player_score == 21
      puts "You are holding #{@player_hand.to_h.keys}"
      puts "Which adds up to #{@player_score}"
      puts "Would you like to hit or stay?"
      choice = gets.chomp

      if choice == "hit"
        hit(@player_hand)
        @player_score = hand_value(@player_hand)
      end

      if @computer_score < 17
        hit(@computer_hand)
        @computer_score = hand_value(@computer_hand)
      end
    end until choice == "stay" || (bust? @computer_score) || (bust? @player_score)

    winner_message
  end

  def winner_message
    if bust? @player_score
      return puts "Computer wins you had #{@player_score} which is over 21"
    end

    if bust? @computer_score
      return puts "You win the dealer had #{@computer_score} which is over 21"
    end

    if @player_score > @computer_score
      puts "Player 1 won with #{@player_hand}"
    else
      puts "Computer won with #{@computer_hand}"
    end
  end

  def welcome_message
    puts "Welcome to a game of black jack"
    puts "I hope you are ready to play!"
  end
end

