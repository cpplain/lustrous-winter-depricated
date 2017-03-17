FactoryGirl.define do
  factory :author do
    first 'First'
    sequence :middle do |n|
      "Middle#{n}"
    end
    last 'Last'
  end
end
