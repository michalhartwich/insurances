require 'rails_helper'
require 'spec_helper'

RSpec.describe Client, :type => :model do
  
  it 'should return merged name and surname' do
    contact = FactoryGirl.create(:client, name: 'John', surname: 'Doe')
    expect(contact.full_name).to eq('John Doe')
  end

end
