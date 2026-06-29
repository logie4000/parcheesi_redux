require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the RadioShowsHelper. For example:
#
# describe RadioShowsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe RadioShowsHelper, type: :helper do
  let!(:dee_jay) { create(:dee_jay, mixcloud_user: "logie4000") }
  let!(:radio_show) { create(:radio_show, dee_jay_id: dee_jay.id, web_link: "https://www.mixcloud.com/logie4000/parcheesi-redux-tuesday-edition-week-25/") }
    
  context 'mixcloud_player_url' do
    it 'should generate the correct url' do
      @url = "https://www.mixcloud.com/widget/iframe/?feed=%2Flogie4000%2Fparcheesi-redux-tuesday-edition-week-25%2F"
      expect(mixcloud_player_url(radio_show, dee_jay)).to eq(@url)
    end
  end
end
