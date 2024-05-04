# frozen_string_literal: true

# Guardfile

guard :rspec, cmd: 'bundle exec rspec' do
  watch(%r{^spec/.+_spec\.rb$})

  # Exclude *_helper.rb files
  exclude %r{^spec/.+_helper\.rb$}

  # Exclude files under factories/ directory
  exclude %r{^spec/factories/.+\.rb$}

  # Exclude all files in fixtures/ directory
  Dir.glob('spec/fixtures/**/*').each do |file|
    exclude(/^#{Regexp.escape(file)}$/)
  end
end
