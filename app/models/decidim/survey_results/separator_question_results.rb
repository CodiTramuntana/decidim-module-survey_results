# frozen_string_literal: true

module Decidim
  module SurveyResults
    class SeparatorQuestionResults < Results

      def initialize(full_questionnaire, question)
        super(full_questionnaire, question, "separator_question_results")
      end

      def compute_results
        {}
      end
    end
  end
end
