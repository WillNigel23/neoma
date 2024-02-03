# Theme configuration file
# ========================
# This file is used for all theme configuration.
# It's where you define everything that's editable in Spina CMS.

Spina::Theme.register do |theme|
  # All views are namespaced based on the theme's name
  theme.name = "neoma"
  theme.title = "Neoma Galeria"

  # Parts
  # Define all editable parts you want to use in your view templates
  #
  # Built-in part types:
  # - Line
  # - MultiLine
  # - Text (Rich text editor)
  # - Image
  # - ImageCollection
  # - Attachment
  # - Option
  # - Repeater
  theme.parts = [
    # General
    {name: "header", title: "Header", hint: "Your header content", part_type: "Spina::Parts::Line"},
    {name: "subheader", title: "Subheader", hint: "Your subheader", part_type: "Spina::Parts::Line"},
    {name: "body", title: "Body", hint: "Your main content", part_type: "Spina::Parts::Text"},
    {name: "date", title: "Date", hint: "Date", part_type: "Spina::Parts::Line"},
    {name: "artist", title: "Artist", part_type: "Spina::Parts::Line"},

    # Exhibition
    {name: 'banner', title: "Banner", part_type: "Spina::Parts::Image"},
    {name: "carousel", title: "Image carousel", part_type: "Spina::Parts::ImageCollection"},
    {
      name: 'section',
      title: "Section",
      hint: "Section for content block",
      parts: %w(header body carousel),
      part_type: "Spina::Parts::Repeater"
    },
  ]

  # View templates
  # Every page has a view template stored in app/views/my_theme/pages/*
  # You define which parts you want to enable for every view template
  # by referencing them from the theme.parts configuration above.
  theme.view_templates = [
    {name: "homepage", title: "Homepage"},
    {name: "exhibits", title: "Exhibits"},
    {name: "exhibit", title: "Exhibit", parts: %w(header subheader date artist banner section)},
  ]

  # Custom pages
  # Some pages should not be created by the user, but generated automatically.
  # By naming them you can reference them in your code.
  theme.custom_pages = [
    {name: "homepage", title: "Homepage", deletable: false, view_template: "homepage"},
    {name: "exhibits", title: "Exhibits", deletable: false, view_template: "exhibits"}
  ]

  # Navigations (optional)
  # If your project has multiple navigations, it can be useful to configure multiple
  # navigations.
  theme.navigations = [
    {name: "main", label: "Main navigation"}
  ]

  # Layout parts (optional)
  # You can create global content that doesn't belong to one specific page. We call these layout parts.
  # You only have to reference the name of the parts you want to have here.
  theme.layout_parts = []

  # Resources (optional)
  # Think of resources as a collection of pages. They are managed separately in Spina
  # allowing you to separate these pages from the 'main' collection of pages.
  theme.resources = [
    {name: "exhibits", label: "Exhibits", view_template: "exhibit", slug: "exhibits"},
  ]

  # Plugins (optional)
  theme.plugins = []

  # Embeds (optional)
  theme.embeds = []
end
