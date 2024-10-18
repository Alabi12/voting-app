# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Position.create([{name: 'President'}, {name: 'Vice President'}, {name: 'Secretary'}, {name: 'Assistant Secretary'}, {name: 'Male Organiser'}, {name: 'Female Organiser'}])

# president = Position.find_by(name: 'President')
# vice_president = Position.find_by(name: 'Vice President')
# secretary = Position.find_by(name: 'Secretary')
# assistant = Position.find_by(name: 'Assistant Secretary')
# male_organiser = Position.find_by(name: 'Male Organiser')
# female_organiser = Position.find_by(name: 'Female Organiser')

# Repeat for other positions and add candidates
# Candidate.create([{ name: 'John Doe', image_url: 'john_doe_image_url', position: president }, { name: 'Jane Smith', image_url: 'jane_smith_image_url', position: vice_president }, { name: 'Bob Johnson', image_url: 'bob_johnson_image_url', position: secretary }, { name: 'Alice Williams', image_url: 'alice_williams_image_url', position: assistant }, { name: 'Mike Brown', image_url: 'mike_brown_image_url', position: male_organiser }, { name: 'Sarah Davis', image_url: 'sarah_davis_image_url', position: female_organiser }])

Developer.create(email: "devone@gmail.com", verification_code: "123456")
Developer.create(email: "devtwo@gmail.com", verification_code: "abcdef")
