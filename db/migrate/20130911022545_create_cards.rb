class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :title
      t.text :description
      t.text :type
      t.integer :position

      t.timestamps
    end
  end
end
