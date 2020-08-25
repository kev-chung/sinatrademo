class CreateCakes < ActiveRecord::Migration[5.2]
  def change
  	create_table :cakes do |t|
      t.string :cake, null: false, default: ""

      t.timestamps null: false
    end

    add_index :cakes, :cake, unique: true
  end
end
