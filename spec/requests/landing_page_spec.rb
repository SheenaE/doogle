require 'rails_helper'

describe "Landing_pages" do
  it "should have the content 'Doogle'" do
    visit root_path
    expect(page).to have_content('Doogle')
  end
end
