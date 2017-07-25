class AccessLog < ApplicationRecord
  class << self
    def append(music_info)
      return false unless MusicInformation == music_info.class

      record = self.create(
        access_at:  Time.zone.now,
        music_info_id: music_info.id,
      )
    end
  end
end
