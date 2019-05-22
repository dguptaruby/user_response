# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Clone the project go to directory of project

* bundle install

* rake db:create; rake db:migrate; to crate database and migrate table

* Run sidekiq on new tab `sidekiq`

* `rake delay:manipulation:insert_data` to all 500000 records of user and 10000 question resonse of user

* `rake delay:manipulation:add_accuracy_percentage` to insert overall accuracy % of user.

* Run server `rails s` application is running on localhost:3000


1. What is your approach to determining the length of a week, and why did you choose the input method that you chose?
Ans: I have used the daterangepicker which allow user to select only 7 days not more then that.and  it's user friend anyone can understand that you can't choose more then 7 days difference in dates

2.How can the performance of this app be improved using background jobs?
Ans: I have used the background job to dump the huge data into database,i have also created background jobs for calculating overall accuracy percentage of user.Which update the field in user table.

3.What enhancements would you make to this app if you had more time to work on it?
Ans: we can improve the performance my using raw sql queries,  I have used some but as we have to manipulate through huge amount of data we can use other sql feature like procedure,trigger although i have used sub-query.

4.About how long did this challenge take you?
Ans: 5:45 to 6 hours