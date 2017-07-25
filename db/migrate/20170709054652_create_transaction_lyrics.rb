class CreateTransactionLyrics < ActiveRecord::Migration[5.1]
  def change
    create_table :transaction_lyrics do |t|
      t.bigint  :lyric_id,    null: false
      t.string  :type,        null: true, default: :english
      t.text    :trans_lyric, null: false

      t.timestamps
    end
  end
end
