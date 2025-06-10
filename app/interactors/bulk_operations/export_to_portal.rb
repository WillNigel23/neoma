require 'zip'

class BulkOperations::ExportToPortal

  include Interactor

  def call
    context.file_stream = Zip::OutputStream.write_buffer do |zos|
      zos.put_next_entry('artists.yml')
      zos.write artists_map.to_yaml

      zos.put_next_entry('artworks.yml')
      zos.write artworks_map.to_yaml

      zos.put_next_entry('exhibits.yml')
      zos.write exhibits_map.to_yaml
    end
  end

  private

  def artists_map
    return @artists_map if defined?(@artists_map)

    @artists_map = []

    Artist.all.each do |artist|
      artist_hash = {}

      artist_hash[:description] = artist.description
      artist_hash[:full_name]   = artist.full_name
      artist_hash[:pseudo_name] = artist.name
      artist_hash[:role]        = artist.role
      artist_hash[:status]      = artist.status
      artist_hash[:banner]      = artist.banner&.file&.url
      artist_hash[:portrait]    = artist.portrait&.file&.url

      artist_hash[:content]     = content_sections_to_html_string(artist.content_sections)
      artist_hash[:carousels]   = content_sections_to_carousels(artist.content_sections)

      @artists_map << artist_hash
    end

    @artists_map
  end

  def artworks_map
    return @artworks_map if defined?(@artworks_map)

    @artworks_map = []

    Artwork.all.each do |artwork|
      artwork_hash = {}

      artwork_hash[:description] = artwork.description
      artwork_hash[:medium]      = artwork.medium
      artwork_hash[:price]       = artwork.price
      artwork_hash[:size]        = artwork.size
      artwork_hash[:year]        = artwork.year
      artwork_hash[:title]       = artwork.title
      artwork_hash[:artist]      = artwork.artist&.name
      artwork_hash[:status]      = artwork_status_to_portal(artwork)
      artwork_hash[:image]       = artwork.image&.file&.url

      @artworks_map << artwork_hash
    end

    @artworks_map
  end

  def exhibits_map
    return @exhibits_map if defined?(@exhibits_map)

    @exhibits_map = []

    Exhibit.all.each do |exhibit|
      exhibit_hash = {}

      exhibit_hash[:description] = exhibit.description
      exhibit_hash[:subtitle]    = exhibit.subtitle
      exhibit_hash[:title]       = exhibit.title
      exhibit_hash[:start_date]  = exhibit.start_date
      exhibit_hash[:end_date]    = exhibit.end_date
      exhibit_hash[:status]      = exhibit.status
      exhibit_hash[:artworks]    = exhibit.artworks.pluck(:title)
      exhibit_hash[:banner]      = exhibit.banner&.file&.url
      exhibit_hash[:poster]      = exhibit.poster&.file&.url

      exhibit_hash[:content]     = content_sections_to_html_string(exhibit.content_sections)
      exhibit_hash[:carousels]   = content_sections_to_carousels(exhibit.content_sections)

      @exhibits_map << exhibit_hash
    end

    @exhibits_map
  end

  def content_sections_to_html_string(content_sections)
    html_string = String.new

    content_sections.each do |content_section|
      html_string += "<div><strong>#{content_section.header}</strong></div><br><br>"
      html_string += content_section.content.to_trix_html
      html_string += '<br><br>'
    end

    html_string
  end

  def content_sections_to_carousels(content_sections)
    content_sections.filter_map do |content_section|
      content_section.images.filter_map { |image| image&.file&.url }
    end.flatten
  end

  def artwork_status_to_portal(artwork)
    return 'sold' if artwork.sale_status == 'sold'

    return 'available' if artwork.status == 'live'

    artwork.status
  end

end
