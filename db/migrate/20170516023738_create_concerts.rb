class CreateConcerts < ActiveRecord::Migration
  def change
    create_table :concerts do |t|
      t.string :band
      t.string :venue
      t.date :date
      t.integer :user_id
    end
  end
end
