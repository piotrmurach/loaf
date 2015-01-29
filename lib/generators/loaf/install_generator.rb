# encoding: utf-8

require 'rails/generators'

module Loaf
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../../..", __FILE__)

      desc 'Copy locale file to your application'

      def copy_locale
        copy_file "#{self.class.source_root}/config/locales/loaf.en.yml", "config/locales/loaf.en.yml"
      end
    end # InstallGenerator
  end # Generators
end # Loaf
