# frozen_string_literal: true

module Decidim
  module SurveyResults
    class MatrixQuestionResults < Results

      def initialize(full_questionnaire, question)
        super(full_questionnaire, question, "matrix_question_results")
      end

      # question.answer_options -> columns
      # question.matrix_rows -> rows
      # answers -> user responses
      # Answer has many choices (AnswerChoices)
      def multiple_chart_question
        labels = question.matrix_rows.map{ |row| translated_attribute(row.body) }

        data_rows = []
        question.answer_options.each do |answer_option|
          full_questionnaire.answers.where(question: question).each do |answer|
            question.matrix_rows.each do |matrix_row|

              row_choices = question.answer_options.map do |answer_option|
                answer.choices.where(matrix_row: matrix_row, answer_option: answer_option).count
              end
              data_rows << row_choices
            end
          end
        end

        { labels: labels, data: data_rows }
      end
    end
  end
end
