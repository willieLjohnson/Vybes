require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe "Validations" do
    it "is valid with valid attributes" do
      entry = Entry.new(date: DateTime.now.utc, )
      expect(user).to be_valid
    end
  
    it "is invalid without a name" do
      bad_user = User.new(name: nil, email: "noname@mail.com")
      expect(bad_user).to_not be_valid
    end
  
    it "is invalid without an email" do
      bad_user = User.new(name: "Nomail", email: nil)
      expect(bad_user).to_not be_valid
    end
  end

  describe "Associations" do
    it "should have many entries" do
      assoc = User.reflect_on_association(:entries)
      expect(assoc.macro).to eq :has_many
    end
  end
end
