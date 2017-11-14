class Magazine < ActiveRecord::Base

  has_and_belongs_to_many :categories
  alias_attribute :qualities, :categories

  validates :name, presence: true

  def update_qualities(new_qualities)
    old_qualities = qualities.to_a
    update_attributes! qualities: new_qualities
    quality_changes = old_qualities - new_qualities | new_qualities - old_qualities
    subscribers = quality_changes.map{ |quality| quality.subscribers }.inject(:&)
    { qualities: qualities, affected_subscribers: subscribers }
  end
end

