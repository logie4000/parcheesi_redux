class Track < ApplicationRecord
  belongs_to :radio_show
  belongs_to :song
end
