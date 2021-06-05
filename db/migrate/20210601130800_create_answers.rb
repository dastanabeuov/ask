class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.text :body, null: false
      t.boolean :accept, default: false, null: false
      t.integer :user_id, null: false, foreign_key: true
      t.integer :question_id, null: false, foreign_key: true

      t.timestamps
    end
    add_index :answers, :user_id
    add_index :answers, :question_id
  end
end
