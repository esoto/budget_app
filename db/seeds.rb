# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create default categories
puts "Creating default categories..."

# Income categories
income_categories = Category.default_income_categories
income_categories.each do |attrs|
  Category.find_or_create_by(name: attrs[:name]) do |category|
    category.category_type = attrs[:category_type]
    category.color = attrs[:color]
  end
end

# Expense categories
expense_categories = Category.default_expense_categories
expense_categories.each do |attrs|
  Category.find_or_create_by(name: attrs[:name]) do |category|
    category.category_type = attrs[:category_type]
    category.color = attrs[:color]
  end
end

puts "Created #{Category.count} categories"

# Create a sample budget for the current month
if Budget.count == 0
  puts "Creating sample budget..."

  Budget.create!(
    name: "#{Date.current.strftime('%B %Y')} Budget",
    start_date: Date.current.beginning_of_month,
    end_date: Date.current.end_of_month,
    total_amount: 3000.00
  )

  puts "Created sample budget"
end

puts "Seed data created successfully!"
