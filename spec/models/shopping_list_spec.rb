require 'spec_helper'

describe ShoppingList do 
  it { should belong_to(:user) }
  it { should have_many(:products) }

  it { should validate_presence_of(:title) }
  it { should validate_uniqueness_of(:title) }
end
