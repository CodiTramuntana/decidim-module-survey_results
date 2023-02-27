# frozen_string_literal: true

module Decidim
  module SurveyResults
    class TextQuestionResults < Results

      def initialize(full_questionnaire, question)
        super(full_questionnaire, question, "text_question_results")
      end

      def total_answers_answered_percentage
        "#{(total_countable_answers_count * 100)/full_questionnaire.total_participants}%"
      end

      def total_countable_answers_count
        @total_countable_answers_count ||= @full_questionnaire.answers.where(question: @question).where.not(body: "").count
      end

      def total_answers_not_answered_percentage
        "#{((full_questionnaire.total_participants - total_countable_answers_count) * 100)/full_questionnaire.total_participants}%"
      end

    end
  end
end
