require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }
   # @answer = params[:answer]
  end

  def score
    # @ppp = @answer
    @answer = params[:answer]
    @letters = params[:letters].split('')
    # The word is a word composed of the possibilities, we can proceed
    if check_letters(@answer.split(''), @letters) == true
      # The word does not exists in english
      @display_answer = 'The word does not exists in English' if check_word(@answer) == false # Check api
      # The word is valid
      @display_answer = 'Correct' if check_word(@answer) == true # check api, is valid
    else
      @display_answer = 'The word is not composed of the letters above'
    end
  end

  def check_letters(answer, letters)
    answer.each do |letter|
      return true if letters.include?(letter) == true
    end
  end

  def check_word(answer)
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    response = URI.open(url).read
    data = JSON.parse(response)
    data['found']

  end
end
# tenemos todas las letras. string contiene esta letra?
