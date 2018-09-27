class CreateSubscribeNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :subscribe_notifications do |t|
      t.integer :question_id
      t.integer :user_id

      t.timestamps
    end

    add_index :subscribe_notifications, %i[question_id user_id]
  end
end
