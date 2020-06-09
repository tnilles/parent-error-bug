class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.text :contents
      t.string :rgb
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
