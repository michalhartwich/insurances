class Item < ActiveRecord::Base
  has_and_belongs_to_many :mateiral_policies
  belongs_to :group
  validates :name, :group, presence: true
  
  def to_hint
    {id: id, hint: ([name.presence, description.presence]).join(', ')}
  end
end
