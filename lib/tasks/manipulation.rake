include ActiveSupport
namespace :manipulation do
  desc "insert 500,000 user data and 10,000 question"
  task insert_data: :environment do
    puts "running"
    timezone = TimeZone.all.map(&:name).sort
    ran_ans = [true, false]
    500000.times do |a|
      user = User.create(username: Faker::Name.name ,timezone: timezone.sample)
      10000.times do |b|
        QuestionResponse.create(user_id: user.id, correct: ran_ans.sample, created_at: Faker::Date.between(180.days.ago, Date.today))
      end
    end
  end

  task add_accuracy_percentage: :environment do
    User.find_each do |user|
      user.update_attributes(accuracy_percentage: ((user.correction_count.to_f/user.question_responses.count)*100).round(2))
    end
  end
end
