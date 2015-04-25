class Item < ActiveRecord::Base

  belongs_to :group
  validates :name, :group, presence: true
    
end
