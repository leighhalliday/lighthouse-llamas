class AddRelationships < ActiveRecord::Migration
  def change
    change_table :garments do |t|
      t.references :llama
    end

    change_table :llamas do |t|
      t.references :user
    end
  end
end