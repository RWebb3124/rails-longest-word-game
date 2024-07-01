class GamesController < ApplicationController
  def new
    @numbers = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
  end
end
