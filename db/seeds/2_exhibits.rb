Exhibit.destroy_all

# Past Exhibits
FactoryBot.create(:exhibit, :with_images, :with_end_date, :with_content_sections, content_sections_count: rand(1..3),
  start_date: 60.days.ago, status: :live)
FactoryBot.create(:exhibit, :with_images, :with_end_date, :with_content_sections, content_sections_count: rand(1..3),
  start_date: 40.days.ago, status: :live)

# Ongoing Exhibits
FactoryBot.create(:exhibit, :with_images, :with_content_sections, content_sections_count: rand(1..3), status: :live,
  artworks: [Artwork.all.sample])
FactoryBot.create(:exhibit, :with_images, :with_end_date, :with_content_sections, content_sections_count: rand(1..3),
  status: :live, artworks: [Artwork.all.sample])

# Draft & Archived Exhibits
FactoryBot.create(:exhibit, :with_images, status: :draft)
FactoryBot.create(:exhibit, :with_images, status: :archived)
