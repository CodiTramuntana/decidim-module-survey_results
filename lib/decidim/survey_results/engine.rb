# frozen_string_literal: true

require "rails"
require "decidim/core"
require_relative "extend_components"

module Decidim
  module SurveyResults
    # This is the engine that runs on the public interface of survey_results.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::SurveyResults

      routes do
        # Add engine routes here
        resources :survey_results, only: :index
      end

      initializer "survey_results.webpacker.assets_path" do
        Decidim.register_assets_path File.expand_path("app/packs", root)
      end

      initializer 'survey_results.mount_routes' do |_app|
        Decidim::Core::Engine.routes do
          mount Decidim::SurveyResults::Engine => '/survey_results'
        end
      end
    end
  end
end
