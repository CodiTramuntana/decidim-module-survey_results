# frozen_string_literal: true

module Decidim
  module SurveyResults
    class SurveyResultsController < Decidim::ApplicationController
      include Decidim::ApplicationHelper
      include Decidim::SurveyResults::SurveyResultsHelper

      def show
        @full_questionnaire = FullQuestionnaire.new(questionnaire)
        # @num_answers= @questions.first.answers_count
      end

      private

      def component
        @component ||= Decidim::Component.find(params[:component_id])
      end

      def survey
         @survey ||= ::Decidim::Surveys::Survey.find_by(component: component)
      end

      def questionnaire
         @questionnaire ||= ::Decidim::Forms::Questionnaire.find_by(questionnaire_for: survey)
      end
    end
  end
end
