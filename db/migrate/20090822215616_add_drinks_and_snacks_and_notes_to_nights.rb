class AddDrinksAndSnacksAndNotesToNights < ActiveRecord::Migration
  def self.up
    add_column :nights, :bring_drinks, :boolean
    add_column :nights, :bring_snacks, :boolean
    add_column :nights, :notes, :text
  end

  def self.down
    remove_column :nights, :notes
    remove_column :nights, :bring_snacks
    remove_column :nights, :bring_drinks
  end
end
