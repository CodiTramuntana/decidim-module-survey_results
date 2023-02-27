# frozen_string_literal: true

module Decidim
  module SurveyResults
    class FilesQuestionResults < Results

      def initialize(full_questionnaire, question)
        super(full_questionnaire, question, "files_question_results")
      end
    end
  end
end
