require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'is valid if all elements are present' do
      @product = Product.new
      @test_category = Category.new

      @test_category.name = 'Test'

      @product.name = 'Test'
      @product.price_cents = 5500
      @product.quantity = 7
      @product.category = @test_category

      expect(@product.valid?).to be true
    end

    it 'should have a name' do
      @product = Product.new

      @product.name = 'Test'
      @product.valid?
      expect(@product.errors[:name]).not_to include("can't be blank")
    end

    it "price_cents presence" do
      @product = Product.new
  
      @product.price_cents = 5500
      @product.valid? 
      expect(@product.errors[:price_cents]).not_to  include("can't be blank")
    end

    it "quantity" do
      @product = Product.new
  
      @product.quantity = 7
      @product.valid? 
      expect(@product.errors[:quantity]).not_to  include("can't be blank")
    end

    it "has category_id" do
      @test_category = Category.new
      @product = Product.new

      @product.category = @test_category
      @product.valid? 
      expect(@product.errors[:category]).not_to  include("can't be blank")
    end

  end
end