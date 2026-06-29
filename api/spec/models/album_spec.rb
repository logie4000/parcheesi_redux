require 'rails_helper'

RSpec.describe Album, type: :model do
  subject{ described_class.new( title: "Some title",
                                comment: "Something",
                              )
         }

  let!(:albums) { create_list(:album, 5) }
  
  describe 'Validations' do
    it "is be valid with valid attibutes" do
      expect(subject).to be_valid
    end

    it "is not valid without a title" do
      subject.title = nil
      expect(subject).not_to be_valid
    end
  end

  describe 'Associations' do
    it { should have_many(:songs) }
    it { should have_many(:artists).through(:songs) }
  end
  
  describe 'Album.trim_title' do
    before do
      a1 = albums.first
      a1.title = a1.title + " "
      a1.save!
      
      a2 = albums.last
      a2.title = a2.title + "  "
      a2.save!
    end
    
    context 'when the album title ends in whitespace' do
      it 'should clean up the whitespace' do
        Album.trim_title()
        
        Album.all.each do |a|
          Rails.logger.debug("Testing Album title: '#{a.title}'")
          expect(a.title.last(1)).not_to eq(" ")
        end
      end
    end
  end
end
