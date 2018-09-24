class CreateAuthorizations < ActiveRecord::Migration[5.2]
  def change
    create_table :authorizations do |t|
      t.string :uid
      t.string :nickname
      t.string :provider
      t.integer :user_id

      t.timestamps
    end
  end
end
