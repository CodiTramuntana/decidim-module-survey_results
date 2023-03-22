# frozen_string_literal: true

module Decidim
  module SurveyResults
    class TextQuestionResults < Results

      def initialize(full_questionnaire, question)
        super(full_questionnaire, question, "text_question_results")
      end

      def answered_count
        @answered_count ||= @full_questionnaire.answers.where(question: @question).where.not(body: "").count
      end

      def not_answered_count
        @not_answered_count||= full_questionnaire.total_participants - answered_count
      end

      def answered_percentage
        @answered_percentage||= begin
          if full_questionnaire.total_participants > 0
            (answered_count * 100)/full_questionnaire.total_participants
          else
            0
          end
        end
      end

      def not_answered_percentage
        @not_answered_percentage||= begin
          if full_questionnaire.total_participants > 0
            ((full_questionnaire.total_participants - answered_count) * 100)/full_questionnaire.total_participants
          else
            0
          end
        end
      end


      #--------------------------------------------

      private

      #--------------------------------------------

      # labels: Corresponding translation for "Answered" and "Not Answered"
      # datasets: Returns only one dataset with the results of each column.
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
