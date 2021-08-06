FactoryBot.define do
  factory :weapon do
    name { FFaker::Lorem.name }
    description { FFaker::Lorem.phrase }
    power_base { FFaker::Random.rand(1000..10000) }
    power_step { FFaker::Random.rand(100..1000) }
    level { FFaker::Random.rand(1..99) }
  end
end
