FactoryBot.define do
  factory :content_section do
    header { Faker::Quote.famous_last_words.to_s }
    content do
      "<h1>#{Faker::Book.title}</h1><br><p>#{Faker::Lorem.paragraph}</p><br><ul><li>#{Faker::Lorem.sentence}</li></ul>"
    end

    trait :with_images do
      transient do
        images_count { 1 }
      end

      after(:build) do |content_section, evaluator|
        content_section.images << create_list(:image, evaluator.images_count, :skip_validate_to_create)
      end
    end
  end
end
