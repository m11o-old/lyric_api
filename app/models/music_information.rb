class MusicInformation < ApplicationRecord
  belongs_to :artist
  has_one :lyric

  validates :music_name, presence: true
  validates :lyric_type, inclusion: %w(japanese english)

  class << self
    def build_music_info(info)
      begin
        artist = Artist.find_by artist_name: info[:artist]
        artist_id = artist.present? ? artist.id : nil
        MusicInformation.find_or_create_by(music_name: info[:music_name], artist_id: artist_id) do |record|
          record.lyric_type = info[:type]
          record.artist = Artist.build_artist({artist_name: info[:artist], composer: nil, lyricist: nil})
        end
      rescue => e
        Rails.logger.debug e
        Rails.logger.debug e.backtrace.join("\n")
        nil
      end
    end
  end
end
