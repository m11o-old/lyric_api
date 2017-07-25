class Artist < ApplicationRecord
  has_many :music_information

  validates :artist_name, presence: true

  class << self
    def build_artist(artist_info)
      begin
        Artist.find_or_create_by(artist_name: artist_info[:artist_name]) do |record|
          record.composer = artist_info[:composer].presence || nil
          record.lyricist = artist_info[:lyricist].presence || nil
        end
      rescue => e
        Rails.logger.debug e
        Rails.logger.debug e.backtrace.join("\n")
        nil
      end
    end
  end
end
