require 'rails_helper'

describe Word do

  before { @word = Word.new(name: "tuna") }

  subject { @word }

  it { should respond_to(:name) }
  it { should respond_to(:definitions) }

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

  describe "definition associations" do
    before do
      @word.save
      @word.definitions.create(content: "fish")
      @word.definitions.create(content: "sushi")
    end
    
    it "should destroy associated definitions" do
      definitions = @word.definitions.to_a
      @word.destroy
      expect(definitions).not_to be_empty
      definitions.each do |definition|
        expect(Definition.where(id: definition.id)).to be_empty
      end
    end
  end
end
