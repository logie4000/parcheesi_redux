class Song < ApplicationRecord
  belongs_to :artist, optional: true
  belongs_to :album, optional: true
  belongs_to :last_played_overall, optional: true, class_name: "RadioShow"
  
  has_many :tracks, before_add: [:calculate_last_played]
  has_many :radio_shows, through: :tracks
  #has_many :last_played_by_djs

  validates_presence_of :title
  
  
  scope :find_by_ci, lambda { |attribute, value| where("lower(#{attribute}) = ?", value.downcase) }
    
  def self.post_song(params = {}, dee_jay_id)
    raise ActiveRecord::RecordInvalid unless (self.required_params?(params))
    Rails.logger.debug("Posting song with parameters: #{params.inspect}")
    song_params = params[:song]

    song_params[:artist_name] ||= "UNKNOWN ARTIST"
    song_params[:album_title] ||= "UNKNOWN ALBUM"
    song_params[:album_title].strip!
    song_params[:artist_name].strip!

    # Find a RadioShow
    existing_show = false
    radio_show = RadioShow.find_by(publish_date: song_params[:publish_date], dee_jay_id: dee_jay_id)
    if (radio_show)
      existing_show = true
    else
      radio_show = RadioShow.find_or_create_for_date(song_params[:publish_date], dee_jay_id)
    end
    
    # Find an existing Artist
    artist = Artist.find(song_params[:artist_id]) if (song_params[:artist_id])
    artist = Artist.find_by_ci("name", song_params[:artist_name]).first unless (artist)
    
    # Otherwise auto-create the Artist
    unless (artist)
      comment ||= "AUTO-CREATED"
      Rails.logger.debug("Adding new artist with name = #{song_params[:artist_name]}")
      artist = Artist.create!( {name: song_params[:artist_name], comment: comment} )
    else
      Rails.logger.debug("Found artist: #{artist.inspect}")
    end

    # This is an existing radio show so check to see if there's already an orphaned song for this track
    if (existing_show)
      # Look for an orphaned song that has no artist ID
      radio_show.tracks.each do |t|
        Rails.logger.debug("Checking to see if the song for this track is orphaned: #{t.song.inspect}")
        
        album_title = t.album.title.downcase.strip if (t.album)
        song_title = t.song.title.downcase.strip if (t.song)
        
        if (t.artist == nil && song_title == song_params[:title].downcase && album_title == song_params[:album_title].downcase)
          # We found an orphaned song that has the same title and album as the post parameters, so it probably belongs to the artist we already found
          Rails.logger.debug("Fixing orphaned song: #{t.song.inspect}, for album: #{t.song.album.inspect}")
          artist.songs << t.song
          
          # Fix the album title if necessary
          if (t.album.title.strip!)
            t.album.save
          end
          break
        end
      end
    end
    
    # Find an existing Album with an artist id associated with it
    album = Album.find(song_params[:album_id]) if (song_params[:album_id])
#    album = Album.find_by_ci("title", song_params[:album_title]).find_by(artist_id: artist.id) unless(album)
    
    # Find an existing Album that has the artist on it
    album = artist.albums.find_by_ci("albums.title", song_params[:album_title]).first unless (album)
    
    # Otherwise auto-create the Album
    unless (album)
      song_params[:album_title] ||= "UNKNOWN ALBUM"
      comment ||= "AUTO-CREATED"
      
      Rails.logger.debug("Adding new album with title = #{song_params[:album_title]}, artist_id: #{artist.id}")
      album = Album.create!( {title: song_params[:album_title], comment: comment} )
    else
      Rails.logger.debug("Found album: #{album.inspect}")
    end

    # Check for existing song for this artist and album
    Rails.logger.debug("Searching for existing Song record...")
    song = nil
    song = Song.find_by_ci("title", song_params[:title]).find_by(album_id: album.id)
    
    if (song)
      Rails.logger.debug("Found existing song: #{song.inspect}")
      song.update_attributes( {comment: song_params[:comment]} ) if (song_params[:comment])
      
      # Update the track ordinal if requested
      track = radio_show.tracks.find_by(song: song)
      
      if (track && song_params[:track_ordinal])
        radio_show.add_song(song, {ordinal: song_params[:track_ordinal]})
      elsif (track.nil?)
        # Create a new Track
        Rails.logger.debug("Adding new track...")
        radio_show.add_song(song, {ordinal: song_params[:track_ordinal]})
      else
        Rails.logger.debug("Skipping new track addition because this already existed in the radio show")
      end
    else
      Rails.logger.debug("Adding new song...")
      Song.transaction do # Raises exception when the associations cannot be made
        # Create the song and set the associations
        song = artist.songs.create!( {title: song_params[:title], comment: song_params[:comment]} )
        album.songs << song
        
        # Create a new Track
        Rails.logger.debug("Adding new track...")
        radio_show.add_song(song, {ordinal: song_params[:track_ordinal]})
      end
    end

    return song
  end

  def plays(dee_jay = nil)
    calculate_last_played if (self.total_plays.nil?)
    
    return self.total_plays # unless (dee_jay)
    
    # list = Hash.new
    # dee_jay_plays = 0
    
    # if (self.plays_by_dj)
    #   list = JSON.parse(self.plays_by_dj).with_indifferent_access
    # end
    
    # if (list[dee_jay.id.to_s].nil?)
    #   dee_jay.radio_shows.each do |radio_show|
    #     dee_jay_plays += Track.all.where( "radio_show_id = :radio_show_id AND song_id = :song_id", {radio_show_id: radio_show.id, song_id: self.id} ).size
    #   end
      
    #   list[dee_jay.id.to_s] = dee_jay_plays
    #   self.plays_by_dj = list.to_json
    #   self.save
    # else
    #   dee_jay_plays = list[dee_jay.id.to_s]
    # end
  
    # return dee_jay_plays
  end
  
  def calculate_last_played()
    # DeeJay.all.each do |dee_jay|
    #   last_play = LastPlayedByDj.find_by(song: self, dee_jay: dee_jay)
      
    #   if (last_play.nil?)
    #     last_play = LastPlayedByDj.create(song_id: self.id, dee_jay_id: dee_jay.id)
    #   end
      
    #   all_shows_for_dj = self.radio_shows.where(dee_jay_id: dee_jay.id).order(:publish_date)
    #   last_show = all_shows_for_dj.last
      
    #   if (last_play.radio_show != last_show)
    #     last_play.radio_show = last_show
    #     last_play.total_plays = all_shows_for_dj.size
    #     last_play.save!
    #   end
    # end

    self.last_played_overall = self.radio_shows.order(:publish_date).last
    self.total_plays = self.tracks.size
    self.save
  end
  
  # def last_played_by_dj(dee_jay)
  #   return self.last_played_by_djs.where(dee_jay_id: dee_jay.id).first
  # end
  
  def self.fix_artist_ids
    Song.where(artist_id: nil).each do |song|
      if (song.album)
        Rails.logger.debug "Setting artist id = #{song.album.artist_id} for song id = #{song.id}"
        song.artist_id = song.album.artist_id
        song.save!
      end
    end
  end
  
  # def self.fix_last_played_by_dj
  #   Song.all.each do |song|
  #     song.last_played_by_dj = nil
  #     song.plays_by_dj = nil
  #     song.save!
      
  #     song.calculate_last_played
  #   end
  # end
  
private
  def self.required_params?(params = {})
    Rails.logger.debug "Checking required parameters for post_song: #{params.inspect}"
    return false if (params.empty?)

    return false unless (params[:song])
    song = params[:song]

    return false unless (song[:artist_id] || song[:artist_name])
    return false unless (song[:album_id] || song[:album_title])
    return false unless (song[:song_id] || song[:title])
    return false unless (song[:radio_show_id] || song[:publish_date])
 #   return false unless (song[:track_ordinal])
      
    return true
  end
end
