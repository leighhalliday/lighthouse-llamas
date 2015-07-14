class AddGender < ActiveRecord::Migration
  def change
    change_table :llamas do |t|
      t.string :gender
    end
  end
end