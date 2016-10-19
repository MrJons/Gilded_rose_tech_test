require 'item'

describe Item do

  it "converts item passed in to string" do
    item = Item.new("apple", 3, 8)
    expect(item.to_s).to eq("apple, 3, 8")
  end
end
