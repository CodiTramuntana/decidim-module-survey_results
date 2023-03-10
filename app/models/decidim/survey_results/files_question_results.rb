# frozen_string_literal: true

module Decidim
  module SurveyResults
    class FilesQuestionResults < Results

      def initialize(full_questionnaire, question)
        super(full_questionnaire, question, "files_question_results")
      end

      # def total_answers_files_answered_percentage
      #   "#{(total_answers_files_count[:with_attachments] * 100)/total_participants}%"
      # end

      # def total_answers_files_not_answered_percentage
      #   "#{(total_answers_files_count[:without_attachments] * 100)/total_participants}%"
      # end

      # def total_answers_files_count
      #   total_answers_files = {
      #     with_attachments: 0,
      #     without_attachments: 0
      #   }
        
      #   full_questionnaire.answers.where(question: question).each do |answer|
      #     if answer.attachments.present?
      #       total_answers_files[:with_attachments] += 1
      #     else
      #       total_answers_files[:without_attachments] += 1
      #     end
      #   end

      #   total_answers_files
      # end
    end
  end
end
