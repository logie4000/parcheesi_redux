require 'rails_helper'

RSpec.describe DeeJay, type: :model do
  subject { DeeJay.new(
                       name: "Some One",
                       email: "some_one@email.com",
                       password: "agoodpassword",
                       )
          }

  describe "Associations" do
    it { should have_many(:radio_shows) }
    it { should have_many(:songs).through(:radio_shows) }
    it { should have_many(:artists).through(:songs) }
  end
  
  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).not_to be_valid
    end

    it "is not valid without an email" do
      subject.email = nil
      expect(subject).not_to be_valid
    end

    it "is not valid without a password" do
      subject.password = nil
      expect(subject).not_to be_valid
    end
  end

  describe 'Functions' do
    
  end
end
