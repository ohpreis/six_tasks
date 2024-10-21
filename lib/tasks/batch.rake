namespace :batch do
  desc "Generate new morning pages for users"
  task generate_new: :environment do
    User.all.each do |user|
      user_time = user.time_zone.now
      if user_time.hour == 0 && user_time.min >= 5 && user_time.min <= 20
        MorningPage.create!(created_at: Date.today, user: user, body: "get started")
      end
    end
  end
  desc "Move any doing tasks back to backlog"
  task update_tasks: :environment do
    User.all.each do |user|
      user_time = user.time_zone.now
      if user_time.hour == 0 && user_time.min >= 5 && user_time.min <= 20
        user.tasks.each do |task|
          if task.status == "doing"
            task.status = "backlog"
            task.save!
          end
        end
      end
    end
  end
end
