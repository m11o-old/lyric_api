require "mechanize"
require "nokogiri"
require "uri"
require "kakasi"

class SearchLyrics
  def self.search_lyric(params)
    music_name = params[:music_name]
    artist = params[:artist]
    album = params[:album]

    if music_name.present? || artist.present? || album.present?
      search_lyric = SearchLyrics.new music_name, artist, album
      search_lyric.search
    else
      raise "歌詞情報が不十分です。"
    end
  end

  def initialize(music_name, artist, album)
    @music_name = music_name
    @artist = artist
    @album = album
    @agent = Mechanize.new
  end

  def search
    lyric = utaten
    if lyric.present?
      return lyric
    end
    lyric = lyric_wiki
    if lyric.present?
      return lyric
    else
      return nil
    end
  end

  def resize(name)
    return if name.blank?
    if name.length < 7
      return name
    else
      return name[0, 7]
    end
  end

  def transrate_lyric_on_romaji(lyric)
    Kakasi.kakasi("-Ha -Ka", lyric)
  end

  def j_lyric
    url = "http://search.j-lyric.net/index.php?kt=#{resize(@music_name)}&ct=0&ka=#{resize(@artist)}&ca=0"
    begin
      page = @agent.get(URI.escape url)

      list_page = page.search("#mnb .bdy")
      return nil if list_page.count == 0
      target_hash = list_page.map do |item|
        music_info = item.css("p.mid a")
        next if music_info.blank?
        music_name = music_info.inner_html
        lyric_url = music_info.attribute("href").text
        artist = item.css("p.sml a").inner_html
        {artist: artist, name: music_name, lyric: lyric_url}
      end.compact

      return nil if target_hash == nil
      count = 0
      target_hash.map do |item|
        count += 1
        target_page = @agent.get(item[:lyric])

        lyric = target_page.at("p#Lyric").inner_html

        lyric.gsub!(/<p.*?>/, "")
        lyric.gsub!(/　/, " ")
        lyric.gsub!(/<br>/, "\n")

        item[:lyric] = lyric
        item[:translate_lyric] = transrate_lyric_on_romaji lyric
        {count => item}
      end
    rescue => e
      Rails.logger.debug e
      Rails.logger.debug e.backtrace.join("\n")
      return nil
    end
  end

  def utaten
    url = "http://utaten.com/search/=/sort=popular_sort:asc/artist_name=#{resize(@artist)}/title=#{resize(@music_name)}/"
    begin
      page = @agent.get(URI.escape url)

      check = page.search("#contents .contentBox .contentBox__body .switchTab")
      return nil if check.count == 0
      target_hash = page.search("#contents .contentBox .contentBox__body table td").map do |item|
        music_info = item.css("p.searchResult__title a")
        next if music_info.blank?
        music_name = music_info.inner_html.strip!
        lyric_url = music_info.attribute("href").text
        artist = item.css("p.searchResult__name a").inner_html.strip!
        {artist: artist, name: music_name, lyric: lyric_url}
      end.compact

      return nil if target_hash == nil

      count = 0
      target_hash.map do |item|
        count += 1
        target_page = @agent.get("http://utaten.com/#{item[:lyric]}#sort=popular_sort_asc")

        lyric = target_page.at("#contents > main > article > div.contentBox__body > div.lyricBody > div.medium").inner_html
        lyric.gsub!(/　/, " ")
        lyric.gsub!(/<br>/, "\n")
        lyric.gsub!(/<span class=\"ruby\">/, "")

        main_lyric = lyric.gsub(/<span class=\"rt\">.+?<\/span>/, "")
        main_lyric.gsub!(/<span class=\"rb\">/, "")
        main_lyric.gsub!(/<\/span>/, "")

        trans_lyric = lyric.gsub(/<span class=\"rb\">.+?<\/span>/, "")
        trans_lyric.gsub!(/<span class=\"rt\">/, "")
        trans_lyric.gsub!(/<\/span>/, "")

        type = check_type_for_utaten main_lyric.strip!
        trans_lyric.strip!

        item[:type] = type

        if "english" == type
          main_lyric.gsub!(/  \n\r\n/, "\n")
          trans_lyric.gsub!(/  \n\r\n/, "\n")
        else
          main_lyric.gsub!(/\n\r\n|\n\n/, "\n")
          trans_lyric.gsub!(/\n\r\n|\n\n/, "\n")
          item[:translate_lyric] = transrate_lyric_on_romaji trans_lyric
        end

        item[:lyric] = main_lyric
        {count => item}
      end
    rescue => e
      Rails.logger.debug e
      Rails.logger.debug e.backtrace.join("\n")
      return nil
    end
  end

  def lyric_wiki
    return nil if @artist =~ /[^\x01-\x7E]/ || @music_name =~ /[^\x01-\x7E]/
    url = "http://lyrics.wikia.com/wiki/#{@artist}:#{@music_name}"
    begin
      page = @agent.get(url)

      lyric_dom = page.at("div#mw-content-text div.lyricbox")
      return nil if lyric_dom == nil
      lyric = lyric_dom.inner_html
      lyric.gsub!(/<br>/, "\n")
      {1 => {artist: @artist, name: @music_name, type: "english", lyric: lyric}}
    rescue => e
      Rails.logger.debug e
      Rails.logger.debug e.backtrace.join("\n")
      return nil
    end
  end

  def check_type_for_utaten(lyric)
    lyric_en_word_count = lyric.scan(/[a-zA-Z0-9\']/).size
    en_par = (lyric_en_word_count.to_f / lyric.size.to_f) * 100
    if en_par.round >= 80
      "english"
    else
      "japanese"
    end
  end
end