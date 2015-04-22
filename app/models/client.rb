class Client < ActiveRecord::Base

  before_save :before_save_actions

  validates :surname, :name, presence: true
  validates :PESEL, presence: true, if: 'activity == 1'
  validates :PESEL, uniqueness: true, numericality: { only_integer: true },
            length: {is: 11}, if: -> {self.activity==1 && !self.PESEL.blank?}
  validates :REGON, presence: true, if: 'activity == 0'
  validates :REGON, uniqueness: true, numericality: { only_integer: true },
            length: {is: 10}, if: -> {self.activity==0 && !self.REGON.blank?}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :e_mail, presence: true, format: {with: VALID_EMAIL_REGEX},
            unless: 'e_mail.blank?'

  VALID_ZIPCODE_REGEX = /\d{2}\-\d{3}/
  validates :zip_code, format: {with: VALID_ZIPCODE_REGEX}, unless: 'zip_code.blank?'

  def full_name
    "#{self.name} #{self.surname}"
  end

  def is_company?
    (self.activity == 0) || self.activity.nil?
  end

  def before_save_actions
    self.surname.capitalize!
    self.name.capitalize!
    self.city.capitalize!
    self.street.capitalize!
  end
end
