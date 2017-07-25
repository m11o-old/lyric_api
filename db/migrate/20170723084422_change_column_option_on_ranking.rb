class ChangeColumnOptionOnRanking < ActiveRecord::Migration[5.1]
  def change
    10.times do |i|
      change_column :rankings, ("music_info_id_on_rank" + i.to_s).to_sym, :bigint, null: true
    end
  end
end
