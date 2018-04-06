FactoryBot.define do
  factory :project do
    street "3440 W 131st Ave"
    city "Broomfield"
    state "CO"
    zipcode "80003"
    customer_name "John Doe"
    size_kW 5.5
    number_of_pv_modules 22
    pv_module
    branch
  end
end
