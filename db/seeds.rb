# This file is used to populate the database with some initial data.
#
# Reset the database

require "faker"

MorningPage.destroy_all
Task.destroy_all
User.destroy_all

User.create!(
  first_name: "Oscar",
  last_name: "Preis",
  email: "ohpreis@gmail.com",
  password: "Hillman31",
  password_confirmation: "Hillman31",
  confirmed_at: Time.now.utc
)

User.create!(
  first_name: "Oscar",
  last_name: "Hey",
  email: "ohpreis@hey.com",
  password: "Hillman31",
  password_confirmation: "Hillman31",
  confirmed_at: Time.now.utc
)

# create 5 tasks for each user, 1 in doin, 3 in backlog, 1 in idea
User.all.each do |user|
  # create 3 tasks in backlog
  # create 1 task in idea
  # create 1 task in doing
  3.times do
    Task.create!(
      title: Faker::Book.title,
      status: "backlog",
      user: user
    )
  end
  1.times do
    Task.create!(
      title: Faker::Book.title,
      status: "idea",
      user: user
    )
  end
  1.times do
    Task.create!(
      title: Faker::Book.title,
      status: "doing",
      user: user
    )
  end
end
