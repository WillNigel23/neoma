Exhibit.destroy_all

# Past Exhibits
FactoryBot.create(:exhibit, :with_end_date, :with_content_sections, banner: Image.first,
  poster: Image.last, content_sections_count: rand(1..3), start_date: 60.days.ago, status: :live)
FactoryBot.create(:exhibit, :with_end_date, :with_content_sections, banner: Image.first,
  poster: Image.last, content_sections_count: rand(1..3), start_date: 40.days.ago, status: :live)

# Ongoing Exhibits
FactoryBot.create(:exhibit, :with_content_sections, banner: Image.first, poster: Image.last,
  content_sections_count: rand(1..3), status: :live, artworks: [Artwork.all.sample])
FactoryBot.create(:exhibit, :with_end_date, :with_content_sections, banner: Image.first,
  poster: Image.last, content_sections_count: rand(1..3), status: :live, artworks: [Artwork.all.sample])

# Draft & Archived Exhibits
FactoryBot.create(:exhibit, status: :draft)
FactoryBot.create(:exhibit, status: :archived)
