class CreateTaxonomies < ActiveRecord::Migration[5.1]
  def change
    create_table :taxonomies do |t|
      t.string :name
      t.string :key
      t.string :version
      t.string :owner
      t.text :description
      t.text :notes
      t.text :body

      t.timestamps
    end
  end
end
