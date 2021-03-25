FactoryBot.define do
  factory :search_area do
    shape { 'rect' }
    coordinates { '0,0,10,10' }
    association :level
    association :character
  end
end
