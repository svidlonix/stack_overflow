class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :text
      t.string :type
      t.integer :commenter_id
      t.integer :comment_on_id

      t.timestamps
    end
  end
end
