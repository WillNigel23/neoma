# frozen_string_literal: true

FactoryBot.define do
  factory :content_section do
    header { Faker::Quote.famous_last_words }
    content { "<h1>#{Faker::Book.title}</h1><br><p>#{Faker::Lorem.paragraph}</p><br><ul><li>#{Faker::Lorem.sentence}</li></ul>" }

    trait :with_images do
      images do
        [
          Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/banners/banner.jpg').to_s),
          Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/banners/banner.jpg').to_s)
        ]
      end
    end
  end
end
