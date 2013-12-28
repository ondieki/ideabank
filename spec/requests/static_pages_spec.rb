require 'spec_helper'

describe "Static pages" do

  describe "Home Page" do

    it "should have the content 'Idea Bank'" do
      visit '/user/home'
      expect(page).to have_content('Idea Bank')
    end

  end
end

