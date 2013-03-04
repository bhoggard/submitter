class AddWebsiteToWork < ActiveRecord::Migration
  def change
    add_column :works, :website, :string
  end
end
