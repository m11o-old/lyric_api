class ChangeShceme < ActiveRecord::Migration[5.1]
  def change
    remove_column :lyrics, :artist_id
    rename_table :music_infomations, :music_informations
    rename_table :transaction_lyrics, :translation_lyrics
  end
end
