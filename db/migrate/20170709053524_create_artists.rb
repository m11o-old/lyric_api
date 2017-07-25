class CreateArtists < ActiveRecord::Migration[5.1]
  def change
    create_table :artists do |t|
      t.string  :artist_name,  null: false
      t.string  :composer,     null: true, default: nil
      t.string  :lyricist,     null: true, default: nil

      t.timestamps
    end
  end
end
