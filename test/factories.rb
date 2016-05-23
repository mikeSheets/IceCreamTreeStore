FactoryGirl.define do

  factory :product do
    sequence :name do |n|
       "product #{n}"
     end
     sequence :permalink do |n|
        "product-#{n}"
     end
     on_hand 10
     price 50.00
     sequence :description do |n|
       "description-#{n}"
     end
  end

  factory :order_item do
    source { create(:product) }
    order { create(:order) }
    quantity 1
  end

  factory :order do |n|
    user { create(:user) }
    address { user.address || create(:address) }

  factory :user do |n|
    sequence :name do |n|
      "name-#{n}"
    end
    sequence :email do |n|
      "email-#{n}"
    end
    sequence :email_confirmation do |n|
      "confirm email-#{n}"
    end

  factory :address do |n|
    sequence :line1 do |n|
      "line 1-#{n}"
    end
    sequence :line2 do |n|
      "line 2-#{n}"
    end
    sequence :city do |n|
      "city-#{n}"
    end
    zip 00000
  end


end