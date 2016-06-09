class Event < ActiveRecord::Base
  belongs_to :user
  has_many :plans
  validates :name, :city, presence: true
end
