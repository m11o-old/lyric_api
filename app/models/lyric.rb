class Lyric < ApplicationRecord
  belongs_to :music_information, foreign_key: :music_information_id
  has_one :translation_lyric

  validates :lyric, presence: true

  class << self
    def save_with_info(lyric_info)
      begin
        count = 0
        lyric_info.each do |info|
          count += 1
          new_lyric = Lyric.new
          new_lyric.lyric = info[count][:lyric]
          new_lyric.music_information = MusicInformation.build_music_info({music_name: info[count][:name], type: info[count][:type], artist: info[count][:artist]})
          new_lyric.translation_lyric = TranslationLyric.build_trans_lyric({trans_lyric: info[count][:translate_lyric], type: info[count][:type].present? ? (info[count][:type] == "japanese" ? "english" : "japanese") : nil}) if info[count][:translate_lyric].present?
          new_lyric.save!
          new_lyric
        end
      rescue => e
        Rails.logger.debug e
        Rails.logger.debug e.backtrace.join("\n")
        nil
      end
    end
  end
end
