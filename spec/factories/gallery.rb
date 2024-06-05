FactoryBot.define do
  factory :gallery do
    title { "#{Faker::Movie.unique.title} #{Time.current.to_i}" }
    location { Faker::Locations::Australia.location }
    description { Faker::Movie.quote }

    trait :with_banner do
      banner { create(:image, :skip_validate_to_create) }
    end

    trait :with_artworks do
      transient do
        artworks_count { 1 }
      end

      after(:create) do |gallery, evaluator|
        create_list(:artwork, evaluator.artworks_count, galleries: [gallery])
      end
    end

    trait :with_content_sections do
      transient do
        content_sections_count { 1 }
      end

      after(:create) do |gallery, evaluator|
        gallery.content_sections << create_list(:content_section, evaluator.content_sections_count)
      end
    end

    trait :as_featured do
      featured_item { create(:featured_item) }
    end
  end
end
