# frozen_string_literal: true

module Decidim
  module SurveyResults
    class MatrixQuestionResults < Results

      def initialize(full_questionnaire, question)
        super(full_questionnaire, question, "matrix_question_results")
      end

      #-----------------------------------------------

      private

      #-----------------------------------------------

      # labels: data_rows body
      # datasets: An array of hashes with two fields, label and data.
      # Each dataset contains the results of a column in its `data` field.
      # This is, each dataset contains and array with the count of
      # choices on each row of the column.
      #
      # For example, dataset data for column A: [
      #  1, <- one user voted A on row 1
      #  5, <- five users voted A on row 2
      #  3, <- three users voted A on row 3
      # ]
      #
      # NOTE: Correspondence between Decidim models and the matrix
      # question.answer_options -> columns
      # question.matrix_rows -> rows
      # answers -> each is a user response to a question
      # Answer has many choices (AnswerChoices)
      #
      # See the chart expected data here:
      # https://www.chartjs.org/docs/latest/samples/bar/floating.html
      def compute_results
        user_question_answers= full_questionnaire.answers
        choices_sums= Decidim::Forms::AnswerChoice.where("decidim_answer_id IN (#{user_question_answers.select(:id).where(question: question).to_sql})").group(:decidim_question_matrix_row_id, :decidim_answer_option_id).count

        # labels: appear at the x axis
        # datasets: one dataset for the columns of each row
        data= {
          labels: question.matrix_rows.map {|r| translated_attribute(r.body) },
          datasets: []
        }
        question.answer_options.each do |answer_option|
          dataset = {data: []}
          dataset[:label]= translated_attribute(answer_option.body)
          question.matrix_rows.each do |row|
            key= [row.id, answer_option.id]
            dataset[:data] << (choices_sums[key] || 0)
          end
          data[:datasets] << dataset
        end

        data
      end
    end
  end
end
