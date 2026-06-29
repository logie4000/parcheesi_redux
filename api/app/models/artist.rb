class Artist < ApplicationRecord
  has_many :songs, after_add: :clear_plays
  has_many :albums, -> { distinct }, through: :songs
  
  validates_presence_of :name
  
  scope :find_by_ci, lambda { |attribute, value| where("lower(#{attribute}) = ?", value.downcase) }
    
  def clear_plays(artist = nil)
    @total_plays = nil
  end
  
  def plays(dee_jay = nil)
    tot_plays = 0
    self.songs.each do |s|
      tot_plays += s.plays(dee_jay)
    end
    
    return tot_plays
  end
  
  def self.top(count = 30, options = {})
    Song.fix_artist_ids
    
    if (options[:dee_jay_id])
      dee_jay = DeeJay.find(options[:dee_jay_id])
      artists = dee_jay.artists.to_a
    else
      artists = Artist.includes(:songs).all.to_a
    end
    
    # Use the negative of plays so that the two can be sorted desc and ascend
    return artists.sort_by{|artist| [-artist.plays(dee_jay), artist.significant_name]}.first(count)
  end
  
  def significant_name
    @sig_name = nil
    %w{ the a an }.each do |w|
      @sig_name = self.name.gsub(/^#{w}\s+/i, "") if (self.name =~ /^#{w}\s+/i)
    end
    
    @sig_name ||= self.name
    return @sig_name
  end
end
