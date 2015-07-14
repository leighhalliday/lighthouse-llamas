class CreateTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.timestamps
    end

    create_table :llamas do |t|
      t.string :name
      t.integer :age
      t.string :quality
      t.timestamps
    end

    create_table :garments do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
  end
end