Gallery.destroy_all

5.times do
  FactoryBot.create(:gallery, :with_content_sections, banner: Image.first, content_sections_count: rand(1..3),
    artworks: [Artwork.all.sample], status: :live)
end
