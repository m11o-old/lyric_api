class ChangeColumnMusicInfomationIdOnLyric < ActiveRecord::Migration[5.1]
  def change
    add_column :lyrics, :music_information_id, :integer, after: :music_infomation_id, null: false
    remove_column :lyrics, :music_infomation_id
  end
end
