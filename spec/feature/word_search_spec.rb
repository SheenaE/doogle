require 'rails_helper'

describe "Word Search" do
  before { visit root_path }

  context "The home page" do

    it "should have content 'Doogle'" do
      expect(page).to have_content('Doogle')
    end

    it "should have an input field" do
      expect(page).to have_field('search', type: 'text')
    end

    it "should have a submit button" do
      expect(page).to have_css("input.btn")
    end

    it "should not have the error message" do
      expect(page).to have_no_content("That word is not in the database!")
    end
  end

  context "When the word doesn't locally exist" do
    before do
      tuna = Word.find_by_name('tuna')
      tuna.destroy unless tuna.nil?
      fill_in "search", :with => "tuna"
      click_button 'Search'
      @definitions = Word.find_by_name('tuna').definitions
    end

    it "should not have the error message" do
      expect(page).to have_no_content("That word is not in the database!")
    end

    it "should show associated definitions" do
      @definitions.each do |d|
        d = d.content.gsub(/<*>/,"")
        expect(page).to have_css("li", d)
      end
    end

    it "should still be on the same page" do
      expect(current_path).to eq words_path
    end
  end

  context "When the word isn't a real word" do
    before do
      fill_in "search", :with => "doogle"
      click_button 'Search'
    end

    it "should show the error message" do
      expect(page).to have_content("That word is not in the database!")
    end
  end
end
