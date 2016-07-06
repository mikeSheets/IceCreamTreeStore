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

  factory :order do
    user { create(:user) }
    address { user.address || create(:address) }
  end

  factory :user do
    sequence :name do |n|
      "name-#{n}"
    end
    sequence :email do |n|
      "email-#{n}@example.com"
    end
    role User::USER
    password 'password'
    password_confirmation 'password'
  end

  factory :address do
    name 'name'
    sequence :line1 do |n|
      "line 1-#{n}"
    end
    sequence :line2 do |n|
      "line 2-#{n}"
    end
    sequence :city do |n|
      "city-#{n}"
    end
    state { State.first || create(:state) }
    zip 00000
    user { create(:user) }
  end

	factory :state do
		sequence :name do |n|
			"name-#{n}"
		end
		sequence :abbreviation do |n|
			"abbreviation-#{n}"
		end
  end

  factory :payment do
    order { create(:order) }
    credit_card { create(:credit_card) }
    amount 25.00
  end

  factory :credit_card do
    number "4111111111111111"
    #last_four
    cvc 123
    month 10
    year 2020
    user { create(:user) }
    sequence :name do |n|
      "name-#{n}"
    end
  end
end