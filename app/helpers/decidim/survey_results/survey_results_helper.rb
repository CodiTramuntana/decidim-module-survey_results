# frozen_string_literal: true

module Decidim
  module SurveyResults
    module SurveyResultsHelper

      def render_question_results(full_questionnaire, question)
        results= Results.for(full_questionnaire, question)
        render partial: results.partial_name, locals: {
          full_questionnaire:,
          results:,
          labels: results.x_labels,
          datasets: results.datasets
        }
      end

    end
  end
end
