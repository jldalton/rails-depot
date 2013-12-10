require 'test_helper'

class ProductTest < ActiveSupport::TestCase
    fixtures :products

  test "product attributes must not be empty" do
      product = Product.new
      assert product.invalid?
      assert product.errors[:title].any?
      assert product.errors[:description].any?
      assert product.errors[:price].any?
      assert product.errors[:image_url].any?
  end


  test "price must not be negative" do
      product = Product.new(title: "My Book Title",
          description: "yyy",
          image_url: "zzz.jpg")
      product.price = -1
      assert product.invalid?
      assert_equal ["must be greater than or equal to 0.01"],
          product.errors[:price]
  end

  test "price must not be zero" do
      product = Product.new(title: "My Book Title",
          description: "yyy",
          image_url: "zzz.jpg")

      product.price = 0
      assert product.invalid?
      assert_equal ["must be greater than or equal to 0.01"],
          product.errors[:price]
  end

  test "price must be positive" do
      product = Product.new(title: "My Book Title",
          description: "yyy",
          image_url: "zzz.jpg")
      product.price = 0.01
      assert product.valid?
  end

  def new_product(image_url)
      product = Product.new(title: "My Book Title",
          description: "yyy",
          price: 1,
          image_url: image_url)
  end

  test "image url" do
      ok = %w{ file.gif file.jpg file.png FILE.JPG FILE.Jpg http://a.b.c/x/y/z/file.gif }
      bad = %w{ file.doc file.gif/more file.gif.more }

      ok.each do |name|
          assert new_product(name).valid?, "#{name} should be valid"
      end
      bad.each do |name|
          assert new_product(name).invalid?, "#{name} should not be valid"
      end
  end

  test "product must have a unique title" do
      product = Product.new(title: products(:ruby).title,
          description: "yyy",
          price: 1,
          image_url: "file.gif")
      assert product.invalid?
      assert_equal ["has already been taken"], product.errors[:title]
      # or
      # does not work assert_equal [II8n.translate('errors.messages.taken')], product.errors[:title]

  end


  
end
