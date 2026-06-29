class RadioShow < ApplicationRecord
  belongs_to :dee_jay, optional: true
  has_many :tracks
  has_many :songs, -> { distinct }, through: :tracks
  
  validates_presence_of :title, :publish_date

  def self.find_or_create_for_date(date, dee_jay_id, options = {})
    dee_jay = DeeJay.find_by(id: dee_jay_id)
    
    raise ActiveRecord::RecordInvalid unless (dee_jay)
    radio_show = RadioShow.find_by(publish_date: date, dee_jay_id: dee_jay_id)

    Rails.logger.debug("Found RadioShow: #{radio_show.inspect}") if radio_show
    
    unless (radio_show)
      d = Date.parse(date.to_s)
      title = options[:title] || "Parcheesi Redux #{d.strftime('%A')}"
      radio_show = dee_jay.radio_shows.create!( {publish_date: date, title: title} )
      Rails.logger.debug("Created new RadioShow: #{radio_show.inspect}")
    end

    return radio_show
  end
  
  def add_song(song, options = {})
    Rails.logger.debug "Adding song to RadioShow id = #{self.id} with options = #{options.inspect}"
    
    # Find an existing track for this song
    track = self.tracks.find_by(song: song)
    if (track)
      track.ordinal = options[:ordinal]
      track.save!
    else
      ordinal = options[:ordinal] || self.tracks.size + 1
      self.tracks.create!( {ordinal: ordinal, song_id: song.id} )
    end
  end
  
  def clean_tracks
    Rails.logger.debug("Start cleaning up existing tracks...")
    self.tracks.each do |t|
      # Clean up the database
      if (t.album && t.album.title =~ /\s+$/)
        t.album.title.strip!
        t.album.save!
      end
    end
  end
end
