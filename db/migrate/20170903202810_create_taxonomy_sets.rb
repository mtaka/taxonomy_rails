class CreateTaxonomySets < ActiveRecord::Migration[5.1]
  def change
    create_table :taxonomy_sets do |t|
      t.string :name
      t.text :description
      t.string :version

      t.timestamps
    end
  end
end
