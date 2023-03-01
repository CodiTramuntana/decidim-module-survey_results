# frozen_string_literal: true

module Decidim
  module SurveyResults
    class FilesQuestionResults < Results

      def initialize(full_questionnaire, question)
        super(full_questionnaire, question, "files_question_results")
      end

      def total_anwers_files_answered_percentage(question)
        "#{(total_answers_files_count(question)[:with_attachments] * 100)/total_participants}%"
      end

      def total_anwers_files_not_answered_percentage(question)
        "#{(total_answers_files_count(question)[:without_attachments] * 100)/total_participants}%"
      end

    end
  end
end
