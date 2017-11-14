class Subscriber < ActiveRecord::Base

  has_and_belongs_to_many :categories
  alias_attribute :interests, :categories

  validates :name, presence: true

  def self.create_subscriber(name:, interests:)
    subscriber = create! name: name, interests: interests
    magazines = interests.map{ |interest| interest.magazines }.inject(:&)
    { subscriber: subscriber, magazines: magazines }
  end
end
