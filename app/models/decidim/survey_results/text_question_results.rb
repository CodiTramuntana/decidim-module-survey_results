# frozen_string_literal: true

module Decidim
  module SurveyResults
    class TextQuestionResults < Results

      def initialize(full_questionnaire, question)
        super(full_questionnaire, question, "text_question_results")
      end

      def x_labels
        results[:labels]
      end

      # Returns only one dataset with the results of each column.
      def datasets
        results[:datasets]
      end

      def results
        @results||= compute_results
      end


      def answered_count
        @answered_count ||= @full_questionnaire.answers.where(question: @question).where.not(body: "").count
      end

      def not_answered_count
        @not_answered_count||= full_questionnaire.total_participants - answered_count
      end

      def answered_percentage
        @answered_percentage||= (answered_count * 100)/full_questionnaire.total_participants
      end

      def not_answered_percentage
        @not_answered_percentage||= ((full_questionnaire.total_participants - answered_count) * 100)/full_questionnaire.total_participants
      end


      #--------------------------------------------

      private

      #--------------------------------------------

      def compute_results
        data= {
          labels: [
            I18n.t("survey_results.question_results.answered"),
            I18n.t("survey_results.question_results.not_answered")
          ],
          datasets: [
            {data: [answered_count, not_answered_count]}
          ]
        }
      end
    end
  end
end
