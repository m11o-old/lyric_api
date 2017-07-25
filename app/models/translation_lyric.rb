class TranslationLyric < ApplicationRecord
  belongs_to :lyric

  validates :trans_lyric, presence: true
  validates :lyric_type, inclusion: %w(japanese english)

  class << self
    def build_trans_lyric(trans_lyric_info)
      begin
        trans_lyric = TranslationLyric.new
        trans_lyric.trans_lyric = trans_lyric_info[:trans_lyric]
        trans_lyric.lyric_type = trans_lyric_info[:type].presence || nil
        trans_lyric
      rescue => e
        Rails.logger.debug e
        Rails.logger.debug e.backtrace.join("\n")
        nil
      end
    end
  end
end
