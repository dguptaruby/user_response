class User < ApplicationRecord
  has_many :question_responses, dependent: :destroy

  def correction_count
    question_responses.where(correct: true).count
  end

  def latest_question
    question_responses.order("created_at").last
  end

  def acc_start_of_month

    ques_count = question_responses.where("question_responses.created_at > ? AND question_responses.created_at < ?", Time.now.beginning_of_month, Time.now.end_of_month)
    cal_per(ques_count)
  end

  def user_per_of_week(daterange)
    range = daterange.split('-')
    ques_count = question_responses.where("question_responses.created_at BETWEEN ? AND ?", range[0].to_date, range[1].to_date)
    cal_per(ques_count)
  end

  def acc_per_of_week(daterange, curr_user_acc)
    range = daterange.split('-')
    start_date = range[0].to_date.strftime('%Y-%m-%d')
    end_date  = range[1].to_date.strftime('%Y-%m-%d')

    sql = "#{self.sql_query(start_date, end_date, curr_user_acc, '>', 'DESC')}
     UNION
       #{self.sql_query(start_date, end_date, curr_user_acc, '<', 'ASC')}"

    ActiveRecord::Base.connection.exec_query(sql)
  end

  def sql_query(start_date, end_date, curr_user_acc, operator, order_type)
    <<-SQLSTR
    (
      SELECT   users.id,
      ((
         (
           SELECT Count(*)
           FROM   question_responses
           WHERE  question_responses.created_at BETWEEN '#{start_date}' AND    '#{end_date}'
           AND    users.id = question_responses.user_id
       AND    question_responses.correct = true ) * 100.0) div
       (
         SELECT count(*)
         FROM   question_responses
         WHERE  question_responses.created_at BETWEEN '#{start_date}' AND    '#{end_date}'
      AND    users.id = question_responses.user_id)) AS corr_count
      FROM     `users`

      HAVING   corr_count #{operator} #{curr_user_acc}
      ORDER BY corr_count #{order_type} limit 2000)

      SQLSTR
      end


      def global_acc_rank
        User.where('accuracy_percentage  > ?', self.accuracy_percentage).count + 1
      end



      def cal_per(ques_count)
        corr_count = ques_count.where(correct: true).count
        return if corr_count.zero?
        ((corr_count/ques_count.count.to_f)*100).round(2)
      end
      end
