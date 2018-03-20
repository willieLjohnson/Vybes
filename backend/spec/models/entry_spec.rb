require 'rails_helper'

RSpec.describe Entry, type: :model do
  subject {
    User.new(name: "Willie", email: "willies@entries.com")
  }

  describe "Validations" do
    it "is valid with valid attributes" do
      entry = Entry.new(date: DateTime.now.utc, body: "I have a date and user!", user: subject)
      expect(entry).to be_valid
    end
  
    it "is invalid without a date" do
      bad_entry = Entry.new(date: nil, body: "I have no date, but I have a user", user: subject)
      expect(bad_entry).to_not be_valid
    end
  
    it "is invalid without a body" do
      bad_entry = Entry.new(date: DateTime.now.utc, body: nil, user: subject)
      expect(bad_entry).to_not be_valid
    end

    it "is invalid without a user" do
      bad_entry = Entry.new(date: DateTime.now.utc, body: "Today there's no user :(", user: nil)
      expect(bad_entry).to_not be_valid
    end
  end

  describe "Associations" do
    it "should belong to a use" do
      assoc = Entry.reflect_on_association(:user)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
