class CreateMusicInfomations < ActiveRecord::Migration[5.1]
  def change
    create_table :music_infomations do |t|
      t.bigint  :artist_id,  null: false
      t.string  :music_name, null: false
      t.string  :type,       null: true,  default: :japanese

      t.timestamps
    end
  end
end
