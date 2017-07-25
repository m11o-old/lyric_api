class CreateRankings < ActiveRecord::Migration[5.1]
  def change
    create_table :rankings do |t|
      10.times do |i|
        t.bigint    ("music_info_id_on_rank" + i.to_s).to_sym, null: false
        t.string    ("movie_url_on_rank" + i.to_s).to_sym,     null: true, default: nil
      end

      t.date        :ranked_at,  null: false

      t.timestamps
    end
  end
end
