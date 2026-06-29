require 'rails_helper'

RSpec.describe Song, type: :model do
  let!(:artist) { create(:artist) }
  subject{ described_class.new( title: "Some song",
                                comment: "Commentary",
                                artist_id: artist.id,
                              )
         }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).not_to be_valid
    end
  end

  describe 'Associations' do
    it{ should belong_to(:album).without_validating_presence }
    it{ should belong_to(:artist).without_validating_presence }
    it{ should have_many(:tracks) }
    it{ should have_many(:radio_shows).through(:tracks) }
    it{ should belong_to(:last_played_overall).without_validating_presence }
  end

  describe 'Functions' do
    before do
      @max_plays = 30
      @dee_jay = DeeJay.create!( {name: Faker::Lorem.words(number: 2).join(" "), email: Faker::Lorem.words(number: 2).join(".") + "@gmail.com", password: "password"} )
        
      (1..@max_plays).each do |idx|
         @dee_jay.radio_shows.create!( { title: "KnuckySandy Radio Hour", publish_date: Date.parse("2020-03-31") + idx.days })
      end
      
      (1..@max_plays).each do |p|
        artist = Artist.create!( {name: Faker::Lorem.words(number: 2).join(" ")} )
        album = Album.create!( {title:  Faker::Lorem.words(number: 3).join(" ")} )

        song = artist.songs.create!( {title: Faker::Lorem.words(number: 5).join(" ")} )
        album.songs << song

        (1..p).each do |idx|
          radio_show = RadioShow.find(idx)
          radio_show.add_song(song)
        end
      end
    end
    
    context 'plays' do
      it 'should return the number of plays for a given song' do
        first_song = Song.all.first
        last_song = Song.all.last
        expect(first_song.plays).to eq(1)
        expect(last_song.plays).to eq(@max_plays)
      end
    end
    
    context 'calculate_last_played' do
      before do
        @dee_jay2 = DeeJay.create!( {name: Faker::Lorem.words(number: 2).join(" "), email: Faker::Lorem.words(number: 2).join(".") + "@gmail.com", password: "password"} )
        @dee_jay2.radio_shows.create!( { title: "Parcheesi Wednesday", publish_date: Date.parse("2020-03-31") + (@max_plays * 2).days })

        @dee_jay3 = DeeJay.create!( {name: Faker::Lorem.words(number: 2).join(" "), email: Faker::Lorem.words(number: 2).join(".") + "@gmail.com", password: "password"} )
        @last_show3 = @dee_jay3.radio_shows.create!( { title: "Death on the Dancefloor Radio Hour", publish_date: Date.parse("2020-04-30") + (@max_plays * 2).days })

        @last_show = @dee_jay.radio_shows.order(:publish_date).last
        @first_show = @dee_jay.radio_shows.order(:publish_date).first
        @last_show2 = @dee_jay2.radio_shows.order(:publish_date).last
        
        @artist = Artist.create!( {name: Faker::Lorem.words(number: 3).join(" ")} )
        @album = Album.create!( {title: Faker::Lorem.words(number: 5).join(" ")} )

        @song = @artist.songs.create!( { title: Faker::Lorem.words(number: 3).join(" "), album_id: @album.id })
        @song2 = @artist.songs.create!( { title: Faker::Lorem.words(number: 3).join(" "), album_id: @album.id } )
  
        @first_show.add_song(@song)
        @last_show.add_song(@song)
        @last_show2.add_song(@song)
      end
      
      it 'should identify the radio show that last played the song' do
        @song.calculate_last_played
        
        expect(@song.last_played_overall).to eq(@last_show2)
      end
      
      # it 'should identify the radio show for a given dee_jay that last played the song' do
      #   @song.calculate_last_played
        
      #   expect(@song.last_played_by_dj(@dee_jay).radio_show).to eq(@last_show)
      # end
    end
  end
end
