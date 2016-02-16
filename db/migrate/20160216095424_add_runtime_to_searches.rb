class AddRuntimeToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :runtime, :string
  end
end
