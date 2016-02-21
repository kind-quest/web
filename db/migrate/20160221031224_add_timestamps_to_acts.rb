class AddTimestampsToActs < ActiveRecord::Migration
  def change
    add_column(:acts, :created_at, :datetime)
    add_column(:acts, :updated_at, :datetime)

    add_column(:act_views, :created_at, :datetime)
    add_column(:act_views, :updated_at, :datetime)
  end
end
