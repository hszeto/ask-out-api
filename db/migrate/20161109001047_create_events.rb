class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :start_time
      t.datetime :end_time
      t.string :type
      t.integer :attendee
      t.datetime :invite_exp
      t.references :friend, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
