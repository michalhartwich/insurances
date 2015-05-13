class Client < ActiveRecord::Base

  before_save :before_save_actions

  validates :surname, :name, presence: true
  validates :pesel, presence: true, if: 'activity == 1'
  validates :pesel, uniqueness: true, numericality: { only_integer: true },
            length: {is: 11}, if: -> {self.activity==1 && !pesel.blank?}
  validates :regon, presence: true, if: 'activity == 0'
  validates :regon, uniqueness: true, numericality: { only_integer: true },
            length: {is: 10}, if: -> {self.activity==0 && !regon.blank?}

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

  def to_hint
    {id: id, hint: "#{surname.presence} #{name.presence}, " + ([company.presence, regon.presence, 
      pesel.presence, street.presence, city.presence]).compact.join(', ')}
  end

  def before_save_actions
    self.surname.capitalize!
    self.name.capitalize!
    self.city.capitalize!
    self.street.capitalize!
  end
end
