require 'rails_helper'

RSpec.describe Track, type: :model do
  let!(:user) { create(:dee_jay) }
  let!(:radio_show) { create(:radio_show, dee_jay_id: user.id) }
  let!(:artist) {create(:artist) }
  let!(:song) {create(:song, artist_id: artist.id) }

  subject {
            described_class.new( {ordinal: 1, radio_show_id: radio_show.id, song_id: song.id} )
          }

  describe 'Validations' do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without an ordinal" do
      subject.ordinal = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'Associations' do
    it { should belong_to(:radio_show) }
    it { should belong_to(:song).without_validating_presence }
    it { should have_one(:album).through(:song) }
    it { should have_one(:artist).through(:song) }
  end
  
  describe 'Methods' do
  
  end
end
