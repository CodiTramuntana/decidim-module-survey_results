# frozen_string_literal: true

module Decidim
  module SurveyResults
    class FullQuestionnaire

      delegate :title, to: :questionnaire

      def initialize(questionnaire)
        @questionnaire= questionnaire
      end

      def questionnaire
        @questionnaire
      end

      def questions
        @questions ||= Decidim::Forms::Question.includes([:matrix_rows, :answer_options]).where(questionnaire: questionnaire).order(:position, :id)
      end

      def participants
        @participants ||= ::Decidim::Forms::QuestionnaireParticipants.new(questionnaire).participants
      end

      def answers
        @answers ||= Decidim::Forms::Answer.not_separator
                           .not_title_and_description
                           .joins(:question)
                           .where(questionnaire: questionnaire)
      end

      def total_participants
        @total_participants||= participants.count
      end
    end
  end
end
