require 'rails_helper'

describe Definition do
  before do
    @word = Word.create(name: "fish")
    @definition = @word.definitions.build(content: "tuna")
  end

  subject { @definition }

  it { should respond_to(:content) }
  it { should respond_to(:word_id) }
  it { should respond_to(:word) }
  its(:word) { should eq @word }

  it { should be_valid }

  describe "when word_id is not present" do
    before { @definition.word_id = nil }
    it { should_not be_valid }
  end
end
