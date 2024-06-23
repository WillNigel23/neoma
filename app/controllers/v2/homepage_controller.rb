module V2
  class HomepageController < ApplicationController

    def index
      fetch_main_and_sub_objects('exhibit')
      fetch_main_and_sub_objects('artwork')
      fetch_main_and_sub_objects('artist')
      fetch_main_and_sub_objects('article')
      fetch_main_and_sub_objects('gallery')
    end

    private

    def fetch_main_and_sub_objects(featureable_type)
      items = FeaturedItem.send(featureable_type.pluralize).order(position: :asc).
        map { |item| item.featureable if item.featureable.status == 'live' }
      main_object = items.first
      sub_objects = items[1..]

      instance_variable_set("@#{featureable_type.pluralize}", items)
      instance_variable_set("@main_#{featureable_type}", main_object)
      instance_variable_set("@sub_#{featureable_type.pluralize}", sub_objects)
    end

  end
end
