# frozen_string_literal: true

require 'tailwindcss-rails'

namespace :spina do
  namespace :tailwind do
    def spina_tailwind_compile_command
      "#{Tailwindcss::Engine.root.join('exe/tailwindcss')} -i #{Rails.root.join('app/assets/spina/admin.css')} -o #{Rails.root.join(
        'app/assets/builds/spina/admin.css'
      )}"
    end

    desc 'Build your Tailwind CSS'
    task build: :environment do
      Rails::Generators.invoke('spina:tailwind_config', ['--force'])
      system spina_tailwind_compile_command
    end

    task watch: :environment do
      Rails::Generators.invoke('spina:tailwind_config', ['--force'])
      system "#{spina_tailwind_compile_command} -w"
    end
  end
end

Rake::Task['assets:precompile'].enhance(['spina:tailwind:build']) if Rake::Task.task_defined?('assets:precompile')
