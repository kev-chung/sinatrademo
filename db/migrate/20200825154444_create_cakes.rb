class CreateCakes < ActiveRecord::Migration[5.2]
  def change
  	create_table :cakes do |t|
      t.string :name, null: false, default: ""

      t.timestamps, null: false
    end

    add_index :resources, :name, unique: true
  end
end
