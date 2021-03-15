FactoryBot.define do
  factory :character do
    name { 'Waldo' }
    shape { 'rect' }
    coordinates { '0,0,10,10' }
    association :level
  end
end
