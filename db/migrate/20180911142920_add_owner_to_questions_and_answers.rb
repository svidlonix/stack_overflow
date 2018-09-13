class AddOwnerToQuestionsAndAnswers < ActiveRecord::Migration[5.2]
  def up
    add_column :questions, :owner_id, :integer
    add_column :answers, :owner_id, :integer
  end

  def down
    remove_column :questions, :owner_id, :integer
    remove_column :answers, :owner_id, :integer
  end
end
