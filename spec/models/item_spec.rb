require 'rails_helper'

RSpec.describe Item, type: :model do
  it {expect belong_to :group}
end
