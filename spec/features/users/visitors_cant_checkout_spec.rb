require 'rails_helper'

RSpec.feature "visitor adds items to cart and attempts to checkout" do
  before(:each) do
    @item = create(:course)
  end

  context "and attempts to checkout" do
    scenario "but sees no checkout button but only a signup" do
      visit ("/")
      expect(page).to have_content(@item.title)
      2.times do
        click_on("Add to Cart")
      end
      visit("/cart")
      expect(page).to have_content(@item.title)
      expect(page).to have_content("Quantity: 2")
      expect(page).to_not have_button("Checkout")
      expect(page).to have_content("Login or Create Account to Checkout")
    end
  end
  context "and, after creating a user account" do
    scenario "sees all previous session items ready to be checked out" do
      visit ("/")
      expect(page).to have_content(@item.title)
      expect(page).to have_button("Add to Cart")
      2.times do
        click_on("Add to Cart")
      end
      visit("/cart")
      expect(page).to_not have_button("Checkout")
      within(".checkout-or-login-links") do
        click_on("Create Account")
      end

      fill_in "user[first_name]", with: "Dan"
      fill_in "user[last_name]", with: "Vog"
      fill_in "user[username]", with: "DVOG"
      fill_in "user[password]", with: "password"
      fill_in 'user[street_address]', with: "123 Blueberry Lane"
      fill_in 'user[unit_number]', with: "123"
      fill_in 'user[city]', with: "Seattle"
      fill_in 'user[state]', with: "Washington"
      fill_in 'user[zip_code]', with: "123456"
      click_button "Create Account"

      visit("/cart")
      expect(page).to have_content(@item.title)
      expect(page).to have_content("Quantity: 2")
      expect(page).to have_button("Checkout")
    end
  end
end
