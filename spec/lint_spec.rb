require 'rails_helper'

describe 'Lint Specs' do
  describe 'Controller Specs' do
    excluded_files = [
      # Application Controller
      Rails.root.join('app/controllers/application_controller.rb').to_s,

      # Spina Controllers
      Rails.root.join('app/controllers/spina').to_s,

      # Legacy Controllers
      Rails.root.join('app/controllers/artwork_modals_controller.rb').to_s,
      Rails.root.join('app/controllers/neoma_mailers_controller.rb').to_s
    ]

    Dir[Rails.root.join('app/controllers/**/*.rb')].reject do |controller_file|
      excluded_files.any? { |excluded| controller_file.start_with?(excluded) }
    end.each do |controller_file|
      controller_name = File.basename(controller_file, '.rb')
      controller_directory = File.dirname(controller_file).sub(Rails.root.join('app/controllers').to_s, '')
      spec_directory = File.join('spec', 'requests', controller_directory)
      spec_file = File.join(spec_directory, "#{controller_name}_spec.rb")

      it "#{controller_name} has a corresponding spec file" do
        expect(File).to exist(spec_file), "Expected spec file #{spec_file} to exist for #{controller_name}"
      end
    end
  end

  describe 'Model Specs' do
    excluded_files = [
      # Application Record
      Rails.root.join('app/models/application_record.rb').to_s,

      # Spina Models
      Rails.root.join('app/models/spina').to_s,

      # Linking Tables
      Rails.root.join('app/models/content_image.rb').to_s,
      Rails.root.join('app/models/exhibit_artwork.rb').to_s,
      Rails.root.join('app/models/gallery_artwork.rb').to_s
    ]

    Dir[Rails.root.join('app/models/**/*.rb')].reject do |model_file|
      excluded_files.any? do |excluded|
        model_file.start_with?(excluded)
      end
    end.each do |model_file|
      model_name = File.basename(model_file, '.rb')
      spec_file = Rails.root.join('spec', 'models', "#{model_name}_spec.rb")

      it "#{model_name} has a corresponding spec file" do
        expect(File).to exist(spec_file), "Expected spec file #{spec_file} to exist for #{model_name}"
      end
    end
  end
end
