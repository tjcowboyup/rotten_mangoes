class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :title
      t.string :director
      t.integer :min_runtime
      t.integer :max_runtime

      t.timestamps
    end
  end
end
