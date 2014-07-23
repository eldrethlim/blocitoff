require 'rails_helper'

feature "Visiting Home Page" do
  scenario "See Website Name" do
    visit '/'
    expect(page).to have_content 'Blocitoff'
  end
end