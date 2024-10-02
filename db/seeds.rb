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
  time_zone: "Central Time (US & Canada)",
  password_confirmation: "Hillman31",
  confirmed_at: Time.now.utc
)

User.create!(
  first_name: "Oscar",
  last_name: "Hey",
  email: "ohpreis@hey.com",
  password: "Hillman31",
  time_zone: "Central Time (US & Canada)",
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
  15.times do
    Task.create!(
      title: Faker::Book.title,
      status: "done",
      user: user
    )
  end
  30.times do
    # create body content for the morning page.
    # One line the title, one empty line, and 3 paragraphs, each separated by 2 empty lines
    content = Faker::Book.title + "<br /><br />" + Faker::Lorem.paragraph + "<br /><br />" + Faker::Lorem.paragraph + "<br /><br />" + Faker::Lorem.paragraph

    MorningPage.create!(
      body: content,
      created_at: Date.today - rand(1..30),
      user: user
    )
  end
end
