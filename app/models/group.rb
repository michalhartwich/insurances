class Group < ActiveRecord::Base
  has_many :items, dependent: :destroy
  validates :name, presence: true

  def to_hint
    {id: id, hint: ([name.presence, description.presence]).join(', ')}
  end
end
