class CreateAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :attachments do |t|
      t.string :file
      t.string :type
      t.integer :attacher_id

      t.timestamps
    end
  end
end
