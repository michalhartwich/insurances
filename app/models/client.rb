class Client < ActiveRecord::Base
  validates :surname, :name, presence: true
  validates :PESEL, presence: true, uniqueness: true, 
            length: {is: 11}, :if => 'activity == 1'
  validates :REGON, presence: true, uniqueness: true, 
            length: {is: 10}, :if => 'activity == 0'

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :e_mail, presence: true, format: {with: VALID_EMAIL_REGEX},
            :unless => 'e_mail.blank?'

  def full_name
    "#{self.name} #{self.surname}"
  end

  def is_company?
    (self.activity == 0) || self.activity.nil?
  end
end
