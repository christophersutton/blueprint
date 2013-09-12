class AddParentToCards < ActiveRecord::Migration
  def change
    add_column :cards, :parent_id, :integer
  end
end
