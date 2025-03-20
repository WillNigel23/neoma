module BulkOperations::Lib::Common

  def export_artworks
    @artworks = Artwork.all.includes(:artist)
    attributes = Artwork::ATTRIBUTES

    CSV.generate(headers: true) do |csv|
      csv << attributes

      @artworks.each do |artwork|
        image = artwork.image
        image_url = image.file.url if image&.attached?
        csv << [
          artwork.slug,
          artwork.title,
          artwork.size,
          artwork.medium,
          artwork.price,
          artwork.year,
          artwork.status,
          artwork.sale_status,
          artwork.description.to_s,
          image_url,
          artwork.artist&.slug
        ]
      end
    end
  end

  def import_artworks(csv)
    csv.each do |row|
      if row[0].to_s.present?
        @import.logs += "Artwork: #{row[0]}\n"
        artwork = Artwork.find_or_create_by(slug: row[0])
      else
        @import.logs += "Artwork: #{row[1]}\n"
        artwork = Artwork.find_or_create_by(title: row[1])
      end
      artwork.title = row[1]
      artwork.size = row[2]
      artwork.medium = row[3]
      artwork.price = row[4]
      artwork.year = row[5]
      artwork.status = row[6]
      artwork.sale_status = row[7]
      artwork.description = row[8]
      artwork.image_id = process_image(row[9])
      artwork.artist_id = Artist.find_by(slug: row[10])&.id

      artwork.save!
    end
  end

  def extract_spina_image_url(spina_image)
    return '' if spina_image.nil?

    spina_image.file.url
  end

  def extract_content_sections(content_sections)
    content_objects = []

    content_sections.each do |section|
      content_objects << section.content(:header)
      content_objects << section.content(:body)
      content_objects << section.content(:carousel).map { |image| extract_spina_image_url(image.spina_image) }
    end

    content_objects
  end

  def image_url_maps
    return @image_url_maps if defined?(@image_url_maps)

    @image_url_maps = {}
    Image.find_each do |image|
      next unless image.attached?

      @image_url_maps[image.file.url] = image
    end

    @image_url_maps
  end

  def process_image(url)
    return nil if url.nil?

    # if image_url_maps[url]
    #   @import.logs += "Found existing image for url: #{url}\n"
    #   return image_url_maps[url].id
    # end

    @import.logs += "Creating new image for url: #{url}\n"
    if url.match?(%r{^https://drive\.google\.com/.*$})
      @import.logs += "URL is from google drive\n"
      file_id = url.match(%r{/d/(.*?)(/|$)})[1]
      download_url = "https://drive.google.com/uc?id=#{file_id}&export=download"

      download_url = follow_redirects(download_url)
    else
      download_url = url
    end

    downloaded_image = URI.open(download_url)
    uri = URI.parse(download_url)
    filename = File.basename(uri.path)

    image = Image.new
    image.file.attach(io: downloaded_image, filename:)

    image.save!
    @image_url_maps[url] = image

    image.id
  end

  def follow_redirects(download_url)
    uri = URI(download_url)
    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPRedirection)
      location = response['location']
      if location.include?('accounts.google.com') || location.include?('confirm')
        # If there's a confirm page, append the confirm param
        download_url += '&confirm=t'
        uri = URI(download_url)
      end
    end

    uri.to_s
  end

end
