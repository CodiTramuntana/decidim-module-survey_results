# frozen_string_literal: true

module Decidim
  module SurveyResults
    class Results
      include Decidim::TranslatableAttributes

      def self.for(full_questionnaire, question)
        if %w(single_option multiple_option).include?(question.question_type)
          OptionsQuestionResults.new(full_questionnaire, question)
        elsif %w(short_answer long_answer).include?(question.question_type)
          TextQuestionResults.new(full_questionnaire, question)
        elsif question.question_type == "files"
          FilesQuestionResults.new(full_questionnaire, question)
        elsif question.question_type == "matrix_single"
          MatrixQuestionResults.new(full_questionnaire, question)
        elsif question.question_type == "matrix_multiple"
          MatrixQuestionResults.new(full_questionnaire, question)
        elsif question.question_type == "sorting"
          SortingQuestionResults.new(full_questionnaire, question)
        end
      end

      def initialize(full_questionnaire, question, partial_name)
        @full_questionnaire= full_questionnaire
        @question= question
        @partial_name= partial_name
      end

      attr_reader :question, :partial_name
      attr :full_questionnaire
      delegate :question_type, to: :question

      def total_answers
        @total_answers||= full_questionnaire.answers.where(question: question).count
      end

      def answers_percentage(data)
        return 0 if total_answers == 0
        (data * 100)/total_answers
      end

      # def question_answer_labels
      #   question.answer_options.map do |answer_option|
      #     translated_attribute(answer_option.body)
      #   end
      # end
    end
  end
end
