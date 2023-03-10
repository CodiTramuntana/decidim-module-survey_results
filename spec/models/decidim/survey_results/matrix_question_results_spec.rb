# frozen_string_literal: true

require "spec_helper"

module Decidim::SurveyResults
  describe MatrixQuestionResults do

    let(:current_organization) { create(:organization) }
    let(:participatory_process) { create(:participatory_process, organization: current_organization) }
    let(:questionnaire) { create(:questionnaire, questionnaire_for: participatory_process) }

    let(:question) do
      create(:questionnaire_question,
              question_type: "matrix_single",
              position: 1,
              questionnaire: questionnaire)
    end
    let!(:matrix_row_1) { create(:question_matrix_row, question: question) }
    let!(:answer_option_1) { create(:answer_option, question: question) }
    let!(:answer_option_2) { create(:answer_option, question: question) }
    let!(:answer_option_3) { create(:answer_option, question: question) }
    let!(:answer_1) { create(:answer, questionnaire: questionnaire, question: question) }
    let!(:choice_1_1) { create(:answer_choice, answer: answer_1, answer_option: answer_option_1, matrix_row: matrix_row_1) }
    let!(:answer_2) { create(:answer, questionnaire: questionnaire, question: question) }
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
