# frozen_string_literal: true

Artist.destroy_all

5.times do
  FactoryBot.create(:artist, :with_images, :with_fullname, :with_content_sections, status: :live,
                                                                                   content_sections_count: rand(1..3))
end
