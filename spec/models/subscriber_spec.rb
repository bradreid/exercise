require 'rails_helper'

describe Subscriber do
  describe '#valid?' do
    before(:each) do
      @subscriber = build_stubbed :subscriber
    end
    it 'should be valid' do
      @subscriber.should be_valid
    end
    it 'should be invalid without a name' do
      @subscriber.name = ''
      @subscriber.should be_invalid
    end
  end
  describe '#interests' do
    it 'should have 3 interests' do
      @subscriber = create :subscriber, :with_interests, interests_count: 3
      @subscriber.interests.count.should == 3
    end
  end
  describe '.create_subscriber' do
    before(:each) do
      @magazine_1 = create :magazine, :with_qualities
      @magazine_2 = create :magazine, :with_qualities
      @magazine_3 = create :magazine, qualities: [@magazine_1.qualities.first, @magazine_2.qualities.first]
    end
    it 'should create a new subscriber and return matching magazines (1 & 3)' do
      result = Subscriber.create_subscriber name: 'new sub', interests: [@magazine_1.qualities.first]
      result[:subscriber].name.should == 'new sub'
      result[:magazines].should == [@magazine_1, @magazine_3]
    end
    it 'should create a new subscriber and return matching magazines (2, & 3)' do
      result = Subscriber.create_subscriber name: 'new sub', interests: [@magazine_2.qualities.first]
      result[:subscriber].name.should == 'new sub'
      result[:magazines].should == [@magazine_2, @magazine_3]
    end
    it 'should create a new subscriber and return matching magazines (1)' do
      result = Subscriber.create_subscriber name: 'new sub', interests: [@magazine_1.qualities.last]
      result[:subscriber].name.should == 'new sub'
      result[:magazines].should == [@magazine_1]
    end
    it 'should create a new subscriber and return no matching magazines' do
      interest = create :category, name: 'something different'
      result = Subscriber.create_subscriber name: 'new sub', interests: [interest]
      result[:subscriber].name.should == 'new sub'
      result[:magazines].should == []
    end

  end
end
