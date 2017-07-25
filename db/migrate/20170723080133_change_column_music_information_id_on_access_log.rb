class ChangeColumnMusicInformationIdOnAccessLog < ActiveRecord::Migration[5.1]
  def change
    rename_column :access_logs, :music_information_id, :music_info_id
  end
end
