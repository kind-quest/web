class CreateActViews < ActiveRecord::Migration
  def change
    create_table :act_views do |t|
      t.references :user, index: true, foreign_key: true
      t.references :act, index: true, foreign_key: true
    end
  end
end
