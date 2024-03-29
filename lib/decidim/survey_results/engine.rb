# frozen_string_literal: true

require "rails"
require "decidim/core"

module Decidim
  module SurveyResults
    # This is the engine that runs on the public interface of survey_results.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::SurveyResults

      routes do
        # Add engine routes here
        get "survey/:component_id/results", to: "survey_results#show", as: "survey_results"
      end

      initializer "survey_results.extend_surveys" do
        require "decidim/survey_results/extend_components"
      end

      initializer "survey_results.webpacker.assets_path" do
        Decidim.register_assets_path File.expand_path("app/packs", root)
      end

      initializer 'survey_results.mount_routes' do |_app|
        Decidim::Core::Engine.routes do
          mount Decidim::SurveyResults::Engine => '/survey_results', as: "decidim_survey_results"
        end
      end
    end
  end
end
