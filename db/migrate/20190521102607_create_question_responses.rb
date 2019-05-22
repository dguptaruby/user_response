class CreateQuestionResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :question_responses do |t|
      t.references :user, foreign_key: true
      t.boolean :correct

      t.timestamps
    end
  end
end
