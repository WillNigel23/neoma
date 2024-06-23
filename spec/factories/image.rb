FactoryBot.define do
  factory :image do
    trait :as_banner do
      file { Rack::Test::UploadedFile.new('spec/fixtures/banners/banner.jpg', 'image/jpg') }
    end

    trait :as_portrait do
      file { Rack::Test::UploadedFile.new('spec/fixtures/portraits/portrait.jpg', 'image/jpg') }
    end
  end
end
