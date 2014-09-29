require 'open-uri'

class WordsController < ApplicationController
  def index
    @word = Word.search(params[:search])
    @definitions = @word.definitions unless @word.nil?
  end

  def show
    @word = Word.search(params[:search])
    @definitions = @word.definitions unless @word.nil?
  end

end
