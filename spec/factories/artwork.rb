# frozen_string_literal: true

FactoryBot.define do
  factory :artwork do
    title { Faker::Movie.unique.title }
    description { Faker::Quote.famous_last_words }

    size { '12 x 12 inches' }
    medium { 'Oil on Canvas' }
    year { rand(2024..Date.current.year - 10) }

    price { rand(1000..100_000) }

    trait :with_image do
      image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/portraits/portrait.jpg').to_s) }
    end

    trait :with_artist do
      association :artist
    end
  end
end
