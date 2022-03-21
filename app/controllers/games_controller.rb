require 'json'
require'open-uri'

class GamesController < ApplicationController
  
  def new
    
    @letters = ('A'..'Z').to_a.sample(10)
    
    
  end
  def score
    word = params[:word].upcase
    grid = params[:letters]
    if included?(word, grid)
      
      if  english_word?(params[:word])
        @message = "Well done!"
      else
        @message = "sorry but #{word}} is not an English word!"
      end
    else
      @message = "sorry but #{params[:word].upcase} is not in the grid #{@letters}"

    end
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
  def included?(guess, grid)
    
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end
  
end
