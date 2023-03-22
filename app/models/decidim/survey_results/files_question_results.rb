# frozen_string_literal: true

module Decidim
  module SurveyResults
    class FilesQuestionResults < Results

      def initialize(full_questionnaire, question)
        super(full_questionnaire, question, "files_question_results")
      end

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

      def answered_percentage
        (total_answers_files_count[:with_attachments] * 100)/full_questionnaire.total_participants
      end

      def not_answered_percentage
        (total_answers_files_count[:without_attachments] * 100)/full_questionnaire.total_participants
      end

      def answered_count
        total_answers_files_count[:with_attachments]
      end

      def not_answered_count
        total_answers_files_count[:without_attachments]
      end

      def total_answers_files_count
        total_answers_files_count||= begin
          
          total_answers_files = {
            with_attachments: 0,
            without_attachments: 0
          }
          
          full_questionnaire.answers.where(question: question).each do |answer|
            if answer.attachments.present?
              total_answers_files[:with_attachments] += 1
            else
              total_answers_files[:without_attachments] += 1
            end
          end

          total_answers_files
        end
      end
    end
  end
end
