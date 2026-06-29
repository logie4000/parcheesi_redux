class Album < ApplicationRecord
  has_many :songs
  has_many :artists, -> { distinct }, through: :songs
  
  validates_presence_of :title
  
  scope :find_by_ci, lambda { |attribute, value| where("lower(#{attribute}) = ?", value.downcase) }
  
  def self.trim_title
    Album.all.each do |a|
      a.title.strip! #gsub(/\s$/, "")
      a.save
    end
  end
end
