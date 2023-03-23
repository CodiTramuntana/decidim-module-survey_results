# frozen_string_literal: true

module Decidim
  module SurveyResults
    class SurveyResultsController < ApplicationController
      include Decidim::ApplicationHelper
      include Decidim::SurveyResults::SurveyResultsHelper

      def show
        @full_questionnaire = FullQuestionnaire.new(questionnaire)
      end

      def current_component
        @current_component ||= Decidim::Component.find(params[:component_id])
      end

      def current_participatory_space
        @current_participatory_space ||= current_component.participatory_space
      end

      private

      def survey
         @survey ||= ::Decidim::Surveys::Survey.find_by(component: current_component)
      end

      def questionnaire
         @questionnaire ||= ::Decidim::Forms::Questionnaire.find_by(questionnaire_for: survey)
      end
    end
  end
end
