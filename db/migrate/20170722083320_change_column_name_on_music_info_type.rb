class ChangeColumnNameOnMusicInfoType < ActiveRecord::Migration[5.1]
  def change
    rename_column :music_infomations, :type, :lyric_type
    rename_column :transaction_lyrics, :type, :lyric_type
    add_column :lyrics, :music_infomation_id, :integer, after: :id, null: false
    remove_column :lyrics, :music_info_id
  end
end
