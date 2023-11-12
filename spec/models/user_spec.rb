require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it 'is valid' do
      user = User.new(
        name: 'Sasha Andia',
        email: 'test@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to be_valid
    end

    it 'must have email in field' do
      user = User.new(email: nil)
      expect(user).to be_invalid
      expect(user.errors[:email]).to include("can't be blank")

      user.email = 'test@gmail.com'
      user.valid?
      expect(user.errors[:email]).not_to include("can't be blank")
    end

    it "must have a name in field" do
      user = User.new(name: nil)
      expect(user).to be_invalid
      expect(user.errors[:name]).to include("can't be blank")

      user.name = "Sasha Andia"
      user.valid?
      expect(user.errors[:name]).not_to include("can't be blank")
    end

    it "must have matching passwords" do
      user = User.new(
        password: 'password',
        password_confirmation: 'failiure'
      )
      user.valid?
      expect(user.errors[:password_confirmation]).to be_present
    end

    it "must have a unique email" do
      user = User.new(
        name: "Sasha Andia",
        email: "sasha.andia@gmail.com",
        password: "123456789",
        password_confirmation: "123456789"
      )
      user.save

      u = User.new(
        name: "Sasha Andia",
        email: "sasha.andia@gmail.com",
        password: "123456789",
        password_confirmation: "123456789"
      )
      u.save

      expect(u.errors[:email].first).to eq('has already been taken')
    end

    it 'password length must be at-least 5 characters' do
      user = User.new
      user.name = 'Sasha Andia'
      user.email = 'test@test.com'
      user.password = '1234'
      user.password_confirmation = '1234'
      expect(user).not_to be_valid
    end
  end

  describe ".authenticate_with_credentials" do
    it "should pass with credentials" do
      user = User.new(
        name: "Sasha Andia",
        email: "sasha.andia@gmail.com",
        password: "123456789",
        password_confirmation: "123456789"
      )
      user.save

      user = User.authenticate_with_credentials('sasha.andia@gmail.com', '123456789')
      expect(user).not_to be(nil)
    end

    it "should not pass with wrong credentials" do
      user = User.new(
        name: "Sasha Andia",
        email: "sasha.andia@gmail.com",
        password: "123456789",
        password_confirmation: "123456789"
      )
      user.save

      user = User.authenticate_with_credentials('sasha.andia@gmail.com', '123456')
      expect(user).to be(nil)
    end

    it "should validate credentials, even with spaces before/after email" do
      user = User.new(
        name: "Sasha Andia",
        email: "sasha.andia@gmail.com",
        password: "123456789",
        password_confirmation: "123456789"
      )
      user.save

      user = User.authenticate_with_credentials('  sasha.andia@gmail.com  ', '123456789')
      expect(user).not_to be(nil)
    end

    it "should pass no matter what the case for letters in the email are" do
      user = User.new(
        name: "Sasha Andia",
        email: "sasha.andia@gmail.com",
        password: "123456789",
        password_confirmation: "123456789"
      )
      user.save

      user = User.authenticate_with_credentials('SasHa.andia@gmail.com', '123456789')
      expect(user).not_to be(nil)
    end

  end

end