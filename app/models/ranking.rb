class Ranking < ApplicationRecord
  validates :music_info_id_on_rank0, presence: true
  validates :music_info_id_on_rank1, presence: true
  validates :music_info_id_on_rank2, presence: true
  validates :music_info_id_on_rank3, presence: true
  validates :music_info_id_on_rank4, presence: true
  validates :music_info_id_on_rank5, presence: true
  validates :music_info_id_on_rank6, presence: true
  validates :music_info_id_on_rank7, presence: true
  validates :music_info_id_on_rank8, presence: true
  validates :music_info_id_on_rank9, presence: true
end
