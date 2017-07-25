class CreateAccessLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :access_logs do |t|
      t.datetime :access_at, null: false
      t.bigint :music_information_id, null: false

      t.timestamps
    end
  end
end
