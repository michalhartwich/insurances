class Group < ActiveRecord::Base
  has_many :items, dependent: :destroy
  validates :name, presence: true
end
