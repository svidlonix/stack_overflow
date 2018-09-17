class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.integer :vote, default: 1
      t.string :type
      t.integer :voter_id
      t.integer :vote_for_id

      t.timestamps
    end
  end
end
