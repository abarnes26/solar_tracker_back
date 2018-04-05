FactoryBot.define do
  factory :project do
    street "3440 W 131st Ave"
    city "Broomfield"
    state "CO"
    zipcode "80020"
    customer_name "John Doe"
    size_kW 8
    branch
  end
end
