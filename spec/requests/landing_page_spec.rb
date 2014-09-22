require 'rails_helper'

describe "Landing_pages" do
  before do
    visit root_path
  end

  it "should have the heading 'Doogle'" do
    expect(page).to have_content('Doogle')
  end

  it "should have input text field" do
    expect(page).to have_field('word', :type => 'text')
  end

  it "should have a submit button" do
    expect(page).to have_button('Submit') 
  end
end
