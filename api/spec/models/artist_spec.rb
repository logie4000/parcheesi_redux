require 'rails_helper'

RSpec.describe Artist, type: :model do
  subject { described_class.new( name: "Some Name",
                                 comment: "Something",
                               )
          }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).not_to be_valid
    end
  end

  describe 'Associations' do
    it { should have_many(:songs) }
    it { should have_many(:albums).through(:songs) }
  end
  
  describe 'Functions' do
    before do
      @max_plays = 30
      @dee_jay = DeeJay.create!( {name: Faker::Lorem.words(number: 2).join(" "), email: Faker::Lorem.words(number: 2).join(".") + "@gmail.com", password: "password"} )
      @dee_jay2 = DeeJay.create!( {name: Faker::Lorem.words(number: 2).join(" "), email: Faker::Lorem.words(number: 2).join(".") + "@gmail.com", password: "password"} )
            
      (1..@max_plays).reverse_each do |idx|
        radio_show = @dee_jay.radio_shows.create!( { title: "KnuckySandy Radio Hour", publish_date: Date.parse("2020-03-31") + idx.days })
        @dee_jay2.radio_shows.create!( { title: "Mock Tuna Radio Hour", publish_date: Date.parse("2020-05-31") + idx.days })
          
        artist = Artist.create!( {name: Faker::Lorem.words(number: 2).join(" ")} )
        album = Album.create!( {title:  Faker::Lorem.words(number: 3).join(" ")} )
        
        idx.times do
          song = artist.songs.create!( {title: Faker::Lorem.words(number: 5).join(" ")} )
          album.songs << song
          radio_show.tracks.create!( {song_id: song.id, ordinal: idx} )
        end
      end
    end
    
    context 'plays' do
      it 'should return the number of plays for a given artist' do
        first_artist = Artist.all.first
        last_artist = Artist.all.last
        expect(first_artist.plays).to eq(@max_plays)
        expect(last_artist.plays).to eq(1)
      end
    end
    
    context 'top_30' do
      it 'should return an ordered descending list of artists' do
        artists = Artist.top(@max_plays / 2)
        
        expect(artists.size).to eq(@max_plays / 2)
        
        last_artist = nil
        artists.each do |artist|
          unless (last_artist.nil?)
     #       Rails.logger.debug "Testing top 30 order artist = #{artist.plays}, last_artist = #{last_artist.plays}"
            expect(artist.plays).to be  < (last_artist.plays)
          end
          
          last_artist = artist
        end
      end
      
      it 'should return an ordered descending list of artists for a given dj' do
        @radio_show2 = @dee_jay2.radio_shows.create!( { title: "Mock Tuna Radio Hour", publish_date: Date.parse("2020-05-31") })
        @max_plays.times do |idx|
          @artist = Artist.create!( {name: Faker::Lorem.words(number: 2).join(" ")} )
          @album = Album.create!( {title:  Faker::Lorem.words(number: 3).join(" ")} )
        
          song = @artist.songs.create!( {title: Faker::Lorem.words(number: 5).join(" ")} )
          @album.songs << song
          @radio_show2.tracks.create!( {song_id: song.id, ordinal: idx} )
        end
        
        artists = Artist.top(@max_plays / 2, {dee_jay_id: @dee_jay2.id})
        
        expect(artists.size).to eq(@max_plays / 2)
        
        
        last_artist = nil
        artists.each do |artist|
          unless (last_artist.nil?)
     #       Rails.logger.debug "Testing top 30 order artist = #{artist.plays}, last_artist = #{last_artist.plays}"
            expect(@dee_jay2.artists).to include(artist)
            expect(artist.plays).to be  <= (last_artist.plays)
          end
          
          last_artist = artist
        end
      end
    end
    
    context 'significant_name' do
      # Strips off leading The or A
      before do
        @name = Faker::Lorem.words(number: 2).join(" ")
        @the_artist = Artist.create!( {name: "The #{@name}"})
        @a_artist = Artist.create!( {name: "A #{@name}"} )
        @an_artist = Artist.create!( {name: "An #{@name}"} )
        @artist = Artist.create!( {name: @name} )
        @thermals = Artist.create!( {name: "Thermals"} )
      end
      
      it 'should strip the' do
        name = @the_artist.name
        expect(@the_artist.significant_name).to eq(@name)
        expect(@the_artist.name).to eq(name)
      end
      
      it 'should strip a' do
        name = @a_artist.name
        expect(@a_artist.significant_name).to eq(@name)
        expect(@a_artist.name).to eq(name)
      end
      
      it 'should strip an' do
        name = @an_artist.name
        expect(@an_artist.significant_name).to eq(@name)
        expect(@an_artist.name).to eq(name)
      end
      
      it 'should not strip a significant word' do
        expect(@artist.significant_name).to eq(@name)
      end
      
      it 'should not strip a the first letters of a significant word' do
        expect(@thermals.significant_name).to eq("Thermals")
      end

    end
  end
end
