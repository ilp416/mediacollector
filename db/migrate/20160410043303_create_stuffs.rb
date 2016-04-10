class CreateStuffs < ActiveRecord::Migration
  def change
    create_table :stuffs do |t|
      t.references :user, index: true, foreign_key: true
      t.string :description
      t.string :type
      t.text :target_url

      t.timestamps null: false
    end
  end
end
