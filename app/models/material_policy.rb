class MaterialPolicy < ActiveRecord::Base
  belongs_to :client
  belongs_to :group
  has_and_belongs_to_many :items
  has_many :installments, as: :instable

  validates :client_id, :group_id, :items, :number, :sign_date, :begin_date,
            :expire_date, presence: true
end
