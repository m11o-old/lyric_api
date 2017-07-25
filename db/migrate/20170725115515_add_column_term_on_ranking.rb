class AddColumnTermOnRanking < ActiveRecord::Migration[5.1]
  def change
    add_column :rankings, :term, :string, after: :id, null: false, default: :day
  end
end
