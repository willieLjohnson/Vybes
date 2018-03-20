require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it "is valid with valid attributes" do
      user = User.new(name: "Willie", email: "willie@test.com", password: "1234")
      expect(user).to be_valid
    end
  
    it "is invalid without a name" do
      bad_user = User.new(name: nil, email: "noname@mail.com", password: "1234")
      expect(bad_user).to_not be_valid
    end
  
    it "is invalid without an email" do
      bad_user = User.new(name: "Nomail", email: nil, password: "1234")
      expect(bad_user).to_not be_valid
    end

    it "is invalid without a password" do
      bad_user = User.new(name: "Nomail", email: nil, password: nil)
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
