require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ArtistsHelper. For example:
#
# describe ArtistsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ArtistsHelper, type: :helper do
  describe 'significant_name' do
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
