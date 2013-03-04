class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :email, :null => false
      t.string :phone, :null => false
      t.string :committee_member, :null => false
      t.string :title, :null => false
      t.string :year, :null => false
      t.string :materials, :null => false
      t.integer :height, :null => false
      t.integer :width, :null => false
      t.integer :length
      t.string :edition
      t.integer :estimated_value
      t.string :courtesy
      t.string    :image_file_name
      t.string    :image_content_type
      t.integer   :image_file_size
      t.datetime  :image_updated_at
      t.boolean :confirmed, :null => false, :default => false
      t.timestamps
    end

    add_index :works, [ :last_name, :first_name ]
    add_index :works, :confirmed

  end
end
