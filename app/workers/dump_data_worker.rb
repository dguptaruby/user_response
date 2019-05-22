# class DumpDataWorker
#   include Sidekiq::Worker
#   include ActiveSupport
#   def perform(*args)
#     #Rake::Task['manipulation:insert_data'].invoke


#     puts "running"
#     500000.times do |a|
#       timezone = TimeZone.all.map(&:name).sort
#       user = User.create(username: Faker::Name.name ,timezone: timezone.sample)
#       10000.times do |b|
#         ran_ans = [true, false]
#         QuestionResponse.create(user_id: user.id, correct: ran_ans.sample, created_at: Faker::Date.between(180.days.ago, Date.today))
#       end
#     end

#   end
# end
