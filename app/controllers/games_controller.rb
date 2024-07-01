require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def included?(answer, grid)
    answer.downcase.chars.all? { |letter| answer.count(letter) <= grid.downcase.count(letter) }
  end

  def valid_word?(answer)
    url = "https://dictionary.lewagon.com/#{answer}"
    response = URI.open(url).read
    page = JSON.parse(response)
    page['found']
  end

  def score
    @grid = params[:grid]
    @answer = params[:answer]
    if included?(@answer, @grid)
      if valid_word?(@answer)
        @response = "<b>Congratulations!</b> #{@answer} is a correct and real english word, and is <b>#{@answer.length}</b> letters long".html_safe
      else
        @response = "Sorry, but <b>#{@answer}</b> isn't a real english word".html_safe
      end
    else
      @response = "Sorry, but <b>#{@answer}</b> can't be built out of <b>#{@grid}</b>".html_safe
    end
  end
end
