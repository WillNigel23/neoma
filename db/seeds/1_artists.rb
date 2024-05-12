Artist.destroy_all

5.times do
  FactoryBot.create(:artist, :with_fullname, :with_content_sections, status: :live,
    banner: Image.first, portrait: Image.last, content_sections_count: rand(1..3))
end
