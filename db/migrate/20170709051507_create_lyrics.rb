class CreateLyrics < ActiveRecord::Migration[5.1]
  def change
    create_table :lyrics do |t|
      t.bigint  :music_info_id,  null: false
      t.bigint  :artist_id,      null: false
      t.text    :lyric,          null: false

      t.timestamps
    end
  end
end
