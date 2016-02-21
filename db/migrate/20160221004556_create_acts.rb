class CreateActs < ActiveRecord::Migration
  def change
    create_table :acts do |t|
      t.references :user, index: true, foreign_key: true
      t.text :description
    end
  end
end
