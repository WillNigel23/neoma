# frozen_string_literal: true

FactoryBot.define do
  factory :exhibit do
    title { Faker::Movie.unique.title }
    subtitle { Faker::Movie.quote }
    summary { Faker::Movie.quote }
    start_date { Date.current }
  end

  trait :with_end_date do
    end_date { start_date + 30.days }
  end

  trait :with_images do
    banner { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/banners/banner.jpg').to_s) }
    poster { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/portraits/portrait.jpg').to_s) }
  end
end
