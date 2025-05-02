require 'faker'

# Get existing categories
electronics = Category.find_by(name: "Electronics")
clothing = Category.find_by(name: "Clothing")
books = Category.find_by(name: "Books")
home_kitchen = Category.find_by(name: "Home & Kitchen")

categories = [electronics, clothing, books, home_kitchen]

# Only proceed if all categories are found
if categories.all?
  100.times do
    category = categories.sample
    product = Product.create!(
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.sentence(word_count: 15),
      price: Faker::Commerce.price(range: 10.0..1000.0),
      category: category,
      on_sale: [true, false].sample
    )

    # Optional: Add dummy image if you want
    image_path = Rails.root.join("app/assets/images/placeholder.jpg")
    if File.exist?(image_path)
      product.image.attach(
        io: File.open(image_path),
        filename: "placeholder.jpg",
        content_type: "image/jpg"
      )
    end
  end

  puts "✅ 100 faker-based products created!"
else
  puts "❌ One or more required categories are missing!"
end
