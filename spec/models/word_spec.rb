require 'rails_helper'

describe Word do

  before { @word = Word.new(name: "tuna") }

  subject { @word }

  it { should respond_to(:name) }

  it { should be_valid }

  describe "when name is not present" do
    before { @word.name = " " }
    it { should_not be_valid }
  end

  describe "when the word already exists" do
    before do
      duplicate_word = @word.dup
      duplicate_word.name = @word.name.upcase
      duplicate_word.save
    end
    
    it { should_not be_valid }
  end
end
