class CreateProject < ActiveRecord::Migration
  def self.up
    create_table "projects", :force => true do |t|
      t.column :title,                    :string
      t.column :description,              :text
      t.column :aim,                      :text
      t.column :created_at,               :datetime
      t.column :updated_at,               :datetime
    end
  end

  def self.down
    drop_table "projects"
  end
end
