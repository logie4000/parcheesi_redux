require 'rails_helper'

RSpec.describe RadioShow, type: :model do
  let!(:user) { create(:dee_jay) }
  let!(:artist) { create(:artist) }
  let!(:song) { create(:song, artist_id: artist.id) }
    
  subject {
            described_class.new(title: "Something", publish_date: Date.today)
          }

  describe 'Validations' do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a title" do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a publish_date" do
      subject.publish_date = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'Associations' do
    it { should belong_to(:dee_jay).without_validating_presence }
    it { should have_many(:tracks) }
    it { should have_many(:songs).through(:tracks) }
  end
  
  describe 'Methods' do
    context 'find_or_create_for_date' do
      before do
        @radio_show_1 = RadioShow.create!({ publish_date: "2020-08-18", dee_jay_id: user.id, title: "Mock Tuna Delight" })
      end
      
      it 'should find existing radio show for a given date and dj' do
        show = RadioShow.find_or_create_for_date("2020-08-18", user.id)
        expect(show).not_to be_nil
        expect(show.id).to eq(@radio_show_1.id)
      end

      it 'should create a new radio show for a given date and dj' do
        expect{ RadioShow.find_or_create_for_date("2020-07-18", user.id) }.to change{ RadioShow.all.count }.by(1)
      end
    end
    
    context 'add_song' do
      before do
        @radio_show_1 = RadioShow.create!({ publish_date: "2020-08-18", dee_jay_id: user.id, title: "Mock Tuna Delight" })
      end
      
      it 'should create a new track' do
        expect{ @radio_show_1.add_song(song) }.to change{ Track.all.count }.by(1)
      end
      
      it 'should associate the song with the track' do
        @radio_show_1.add_song(song)
        track = Track.all.last
        
        expect(track.song).to eq(song)
      end
      
      it 'should associate the track with the radio_show' do
        @radio_show_1.add_song(song)
        track = Track.all.last
        
        expect(@radio_show_1.tracks).to include(track)
      end
      
      it 'should set the track ordinal to the end of the list' do
        @radio_show_1.add_song(song)
        track = Track.all.last
        
        expect(track.ordinal).to eq(@radio_show_1.tracks.count)
      end
      
      it 'should set the track ordinal as expected if specified' do
        @ordinal = 5
        @radio_show_1.add_song(song, { ordinal: @ordinal })
        track = Track.all.last
        
        expect(track.ordinal).to eq(@ordinal)
      end
    end
  end
end
