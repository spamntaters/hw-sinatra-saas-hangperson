class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word, :guesses, :wrong_guesses
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess str
    raise ArgumentError unless /\w/.match(str) && str.length > 0
    str.downcase!
    if @word.include? str
      unless @guesses.include? str
        guesses << str
        return true
      end
      return false
    end
    unless @wrong_guesses.include? str
      wrong_guesses << str
      return true
    end
    return false
  end

  def word_with_guesses
    temp_word = ''
    @word.each_char do |letter|
      if guesses.include? letter
        temp_word << letter
      else
        temp_word << '-'
      end
    end
    return temp_word
  end

  def check_win_or_lose
    if @wrong_guesses.length == 7
      return :lose
    elsif !word_with_guesses.include? '-'
      return :win
    else
      return :play
    end
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
