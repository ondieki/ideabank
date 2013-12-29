class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.integer :user_id
      t.string :summary
      t.string :description
      t.integer :votes
      t.integer :purchased
      t.integer :sector
      t.integer :personal_interest
      t.integer :overall_rank

      t.timestamps
    end
  end
end
