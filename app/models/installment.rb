class Installment < ActiveRecord::Base
  belongs_to :instable, polymorphic: true
end
