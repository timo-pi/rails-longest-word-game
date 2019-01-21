require 'open-uri'
require 'json'

class GamesController < ApplicationController

  # CHECK IF ITS A VALID WORD
  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word.upcase}")
    json = JSON.parse(response.read)
    return json['found']
  end

  # CHECK IF CHARS ARE INCLUDED
  def included?(guess, grid)
    guess.upcase.chars.all? { |letter| guess.upcase.count(letter) <= grid.to_s.count(letter) }
  end

  # ACTIONS
  def new
    @letters = Array.new(10) do |_|
      ('A'..'Z').to_a.sample
    end
  end

  def score
    if english_word?(params[:answer]) && included?(params[:answer], params[:grid])
      @score_message = "Congrats, it's an English word and it's build from the letters!"
      elsif included?(params[:answer], params[:grid])
        @score_message = "It's not an english word"
      else
        @score_message = "Different letters!!!"
    end
  end
end
