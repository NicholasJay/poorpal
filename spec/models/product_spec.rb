require 'spec_helper'

describe Product do

  it { should belong_to(:shopping_list) }
  it { should validate_presence_of(:store) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:name) }
   
end
