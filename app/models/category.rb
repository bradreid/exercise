class Category < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_and_belongs_to_many :subscribers
  has_and_belongs_to_many :magazines
end
