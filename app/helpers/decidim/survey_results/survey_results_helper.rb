# frozen_string_literal: true

module Decidim
  module SurveyResults
    module SurveyResultsHelper

      def render_question_results(full_questionnaire, question)
        if question.question_type == "title_and_description"
          render partial: question.question_type, locals: { question: question }
        else
          results= Results.for(full_questionnaire, question)
          render partial: results.partial_name, locals: {
            full_questionnaire:,
            results:,
            labels: results.x_labels,
            datasets: results.datasets
          }
        end
      end

      def conditioned_question?(question)
        Decidim::Forms::DisplayCondition.where(decidim_question_id: question).present?
      end

      def title_and_description_question?(question)
        question.question_type == "title_and_description"
      end
    end
  end
end
