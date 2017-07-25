class ApiController < ApplicationController
  def index
    ranking = Ranking.find_by ranked_at: (Time.zone.now - 1.day).strftime("%Y-%m-%d")

    results = {}
    10.times do |i|
      results.update({("rank" + i.to_s) => ranking.send("music_info_id_on_rank" + i.to_s)})
    end

    render json: results
  end

  def search
    data = search_for_db
    music_info = if data.present?
      data
    else
      lyric_info = SearchLyrics.search_lyric lyric_params
      lyric = Lyric.save_with_info lyric_info
      music_info = if lyric.present?
        lyric.music_information
      else
        lyric_info
      end
    end

    data = if MusicInformation == music_info.class
      AccessLog.append music_info
      trans_lyric = music_info.lyric.translation_lyric.trans_lyric.presence || nil
      {artist: Artist.find(music_info.artist.id).artist_name, name: music_info.music_name, lyric: music_info.lyric.lyric, trans_lyric: trans_lyric}
    else
      music_info
    end

    render json: data
  end

  private

  def lyric_params
    params.permit(:artist, :music_name, :album)
  end

  def search_for_db
    artist = Artist.find_by artist_name: lyric_params[:artist]
    return nil if artist.blank?
    MusicInformation.find_by artist_id: artist.id, music_name: lyric_params[:music_name]
  end
end
