# frozen_string_literal: true

module Decidim
  module SurveyResults
    class MatrixQuestionResults < Results

      def initialize(full_questionnaire, question)
        super(full_questionnaire, question, "matrix_question_results")
      end

      def multiple_chart_question
        datasets = []

        labels = question.matrix_rows.map{ |row| translated_attribute(row.body) }

        question.answer_options.map do |answer_option|
          data_row = []
          full_questionnaire.answers.where(question: question).each do |answer|
            question.matrix_rows.each do |matrix_row|

              row_choices = answer.question.answer_options.map do |answer_option|
                answer.choices.where(matrix_row: matrix_row, answer_option: answer_option).count
              end
              data_row << row_choices
            end
          end
        end

        { labels: labels, data: datasets }
      end
    end
  end
end
