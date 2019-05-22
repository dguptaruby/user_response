class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :timezone
      t.string :accuracy_percentage

      t.timestamps
    end
  end
end
