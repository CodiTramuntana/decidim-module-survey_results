# frozen_string_literal: true

module Decidim
  module SurveyResults
    class SurveyResultsController < Decidim::ApplicationController
      def index
      end

      private

      def component
        @component ||= Decidim::Component.find(params[:component_id])
      end
    end
  end
end
