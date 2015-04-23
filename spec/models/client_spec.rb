require 'rails_helper'
require 'spec_helper'

RSpec.describe Client, :type => :model do

  subject {FactoryGirl.build(:client)}

  it {should validate_presence_of :name}
  it {should validate_presence_of :surname}

  context 'is a company' do
    before {allow(subject).to receive(:activity).and_return(0)}
    it {should validate_presence_of :REGON}
    it {should validate_length_of(:REGON).is_equal_to(10) }
    # it {should validate_uniqueness_of(:REGON)}
    it {should validate_numericality_of(:REGON)}
  end

  context 'is a private person' do
    before {allow(subject).to receive(:activity).and_return(1)}
    it {should validate_presence_of :PESEL}
    it {should validate_length_of(:PESEL).is_equal_to(11)}
    it {should validate_numericality_of :PESEL}
    # it {should validate_uniqueness_of :PESEL}
  end

  context '#full_name' do
    it 'should return merged name and surname' do
      contact = FactoryGirl.build(:client, name: 'John', surname: 'Doe')
      expect(contact.full_name).to eq('John Doe')
    end
  end
  
  context '#before_save_actions' do
    it 'should return fields capitalized' do
      contact = FactoryGirl.build(:client, name: 'john', surname: 'doe', city: 'warsaw', street: 'sLoneCZna')
      contact.before_save_actions
      expect("#{contact.name} #{contact.surname} #{contact.city} #{contact.street}").to eq("John Doe Warsaw Sloneczna")
    end
  end
end
