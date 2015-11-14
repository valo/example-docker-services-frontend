class CreateUsersAndResults < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.integer :total_points, default: 0, null: false
      t.integer :sent_source_codes, default: 0, null: false
      t.timestamps null: false
    end

    create_table :source_codes do |t|
      t.references :user, index: true, foreign_key: true
      t.string :status, null: false
      t.integer :points, null: false
      t.timestamps null: false
    end
  end
end
