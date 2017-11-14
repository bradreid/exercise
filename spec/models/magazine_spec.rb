require 'rails_helper'

describe Magazine do
  describe '#valid?' do
    before(:each) do
      @magazine = build_stubbed :magazine
    end
    it 'should be valid' do
      @magazine.should be_valid
    end
    it 'should be invalid without a name' do
      @magazine.name = ''
      @magazine.should be_invalid
    end
  end
  describe '#qualities' do
    it 'should have 2 qualities' do
      @magazine = create :magazine, :with_qualities, qualities_count: 2
      @magazine.qualities.count.should == 2
    end
  end
  describe '.update_qualities' do
    before(:each) do
      @magazine_1 = create :magazine, :with_qualities
      @magazine_2 = create :magazine, :with_qualities
      @magazine_3 = create :magazine, qualities: [@magazine_1.qualities.first, @magazine_2.qualities.first]
      @subscriber_1 = create :subscriber, interests: [@magazine_1.qualities.first]
      @subscriber_2 = create :subscriber, interests: [@magazine_1.qualities.first, @magazine_2.qualities.first]
      @subscriber_3 = create :subscriber, :with_interests
    end
    it "should remove the magazine's first quality and notify 2 subscribers" do
      result = @magazine_1.update_qualities @magazine_1.qualities.to_a[1..-1]
      result[:affected_subscribers].should == [@subscriber_1, @subscriber_2]
    end
    it "should remove the magazine's first quality and notify 1 subscriber" do
      result = @magazine_2.update_qualities @magazine_2.qualities.to_a[1..-1]
      result[:affected_subscribers].should == [@subscriber_2]
    end
    it 'should add a new quality and notify a new subscriber' do
      result = @magazine_1.update_qualities(@magazine_1.qualities.to_a << @subscriber_3.interests.first)
      result[:affected_subscribers].should == [@subscriber_3]
    end
    it 'should add a new quality and not notify any subscribers' do
      result = @magazine_1.update_qualities(@magazine_1.qualities.to_a << create(:category, name: 'something new'))
      result[:affected_subscribers].should == []
    end
  end
end
