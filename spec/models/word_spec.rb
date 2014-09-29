require 'rails_helper'

describe Word do

  before { @word = build(:word) }
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

  describe "#search" do
    it "returns the word object if it exists locally" do
      result = Word.search(@word.name)
      expect(result).to be_instance_of(Word)
    end

    it "returns nil if the search term is not a word" do
      result = Word.search("doogle")
      expect(result).to be(nil)
    end

    context "the word doesn't exist yet" do
      it "should create and return a word object" do
        word = Word.find_by_name("grumpy")
        word.destroy unless word.nil?
        result = Word.search("grumpy")
        expect(result).to be_instance_of(Word)
      end 
    end
  end
end
