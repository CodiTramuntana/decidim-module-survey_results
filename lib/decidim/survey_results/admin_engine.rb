# frozen_string_literal: true

module Decidim
  module SurveyResults
    # This is the engine that runs on the public interface of `SurveyResults`.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::SurveyResults::Admin

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      routes do
        # Add admin engine routes here
        # resources :survey_results do
        #   collection do
        #     resources :exports, only: [:create]
        #   end
        # end
        # root to: "survey_results#index"
      end

      def load_seed
        nil
      end
    end
  end
end
