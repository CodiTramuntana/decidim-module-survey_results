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
        # resources :survey_results
        # root to: "survey_results#index"
      end

      initializer "SurveyResults.webpacker.assets_path" do
        Decidim.register_assets_path File.expand_path("app/packs", root)
      end
    end
  end
end
