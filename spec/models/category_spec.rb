require 'rails_helper'

describe Category do
  before(:each) do
    @category = build_stubbed :category
  end
  describe '#valid?' do
    it 'should be valid' do
      @category.should be_valid
    end
    it 'should be invalid without a name' do
      @category.name = ''
      @category.should be_invalid
    end
    it 'should be invalid when the name is already taken' do
      create :category, name: 'taken'
      @category.name = 'taken'
      @category.should be_invalid
    end
  end
end
