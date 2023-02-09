# frozen_string_literal: true

module Decidim
  module SurveyResults
    module SurveyResultsHelper
      def total_answers_answered_percentage(question)
        "#{(total_countable_answers_count(question) * 100)/total_participants}%"
      end

      def total_answers_not_answered_percentage(question)
        "#{((total_participants - total_countable_answers_count(question)) * 100)/total_participants}%"
      end

      def total_anwers_files_answered_percentage(question)
        "#{(total_answers_files_count(question)[:with_attachments] * 100)/total_participants}%"
      end

      def total_anwers_files_not_answered_percentage(question)
        "#{(total_answers_files_count(question)[:without_attachments] * 100)/total_participants}%"
      end

      def generic_percentage(data, total_answers)
        "#{(data * 100)/total_answers}%"
      end

      private

      def total_participants
        @participants.count
      end
    end
  end
end
