require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  let (:my_ad) {Advertisement.create ({title: 'ad title', body: 'ad body', price: 200})}

  describe "attributes" do
    it "has a correct body attribute" do
      expect(my_ad).to have_attributes(title: 'ad title', body: 'ad body', price: 200)
    end
  end
end
