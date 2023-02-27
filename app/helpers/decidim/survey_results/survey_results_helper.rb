# frozen_string_literal: true

module Decidim
  module SurveyResults
    module SurveyResultsHelper

      def render_question_results(full_questionnaire, question)
        results= Results.for(full_questionnaire, question)
        render partial: results.partial_name, locals: {full_questionnaire:, results:}
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
