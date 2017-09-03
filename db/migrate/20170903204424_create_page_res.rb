class CreatePageRes < ActiveRecord::Migration[5.1]
  def change
    create_table :page_res do |t|
      t.string :url
      t.string :owner
      t.text :description

      t.timestamps
    end
  end
end
