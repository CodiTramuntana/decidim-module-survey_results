# frozen_string_literal: true

require "spec_helper"

module Decidim::SurveyResults
  describe MatrixQuestionResults do

    let(:question_type) { "matrix_single" }
    include_context "with questionnaire"
    include_context "having one question"
    include_context "having three answer options"
    include_context "having answers from two people"
    let!(:matrix_row_1) { create(:question_matrix_row, question: question) }
    let!(:choice_1_1) { create(:answer_choice, answer: answer_1, answer_option: answer_option_1, matrix_row: matrix_row_1) }
    let!(:choice_2_1) { create(:answer_choice, answer: answer_2, answer_option: answer_option_1, matrix_row: matrix_row_1) }

    let(:results) do
      results= Results.for(FullQuestionnaire.new(questionnaire), question)
    end

    context "with a matrix_single question" do

      it "generates the expected labels for the X axis" do
        expect(results.x_labels).to eq([translated(matrix_row_1.body)])
      end

      it "generates one dataset for each column" do
        expected= [{:data=>[2], :label=> translated(answer_option_1.body)},
         {:data=>[0], :label=> translated(answer_option_2.body)},
         {:data=>[0], :label=> translated(answer_option_3.body)}]

        expect(results.datasets).to eq(expected)
      end
    end
  end
end
