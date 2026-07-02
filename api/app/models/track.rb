class Track < ApplicationRecord
  belongs_to :radio_show
  belongs_to :song
  
  has_one :album, through: :song
  has_one :artist, through: :song
  has_one :dee_jay, through: :radio_show
  
  validates_presence_of :ordinal
end
