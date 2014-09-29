require 'rails_helper'

describe WordsController do
  describe '#show' do
    it 'returns successfully' do
      expect(get :show).to be_success
    end
  end
end