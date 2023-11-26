class AddEventFields < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :subtitle, :string
    add_column :events, :abstract, :string
    add_column :events, :description, :string
    add_column :events, :speakers, :string
  end
end
