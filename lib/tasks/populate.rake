namespace :db do
  desc "erase and fill database"
  task :populate => :environment  do
    require 'faker'

    Entry.delete_all

    # Create competition entries
    500.times do |e|
      Entry.create!(
          :created_at => (rand(12-1)+1).months.ago.to_date,
          :dob => (rand(600-19)+2).months.ago.to_date,
          :firstname      => Faker::Name.first_name,
          :surname        => Faker::Name.last_name,
          :email          => Faker::Internet.email,
          :mobile         => Faker::PhoneNumber.cell_phone,
          :region         => rand(1..9),
          :competition_id => 2,
          :gender         => rand(1..2),
          :newsletter     => rand(0..1),
          :q1             => rand(0..1),
          :q2             => rand(0..1),
          :source         => Faker::Lorem.characters(6)

      )
    end
  end
end