# frozen_string_literal: true

require "spec_helper"

module Decidim::SurveyResults
  describe OptionsQuestionResults do

    let(:current_organization) { create(:organization) }
    let(:participatory_process) { create(:participatory_process, organization: current_organization) }
    let(:questionnaire) { create(:questionnaire, questionnaire_for: participatory_process) }

    let(:question) do
      create(:questionnaire_question,
              question_type: question_type,
              position: 1,
              questionnaire: questionnaire)
    end
    let!(:answer_option_1) { create(:answer_option, question: question) }
    let!(:answer_option_2) { create(:answer_option, question: question) }
    let!(:answer_option_3) { create(:answer_option, question: question) }
    let!(:answer_1) { create(:answer, questionnaire: questionnaire, question: question) }
    let!(:choice_1_1) { create(:answer_choice, answer: answer_1, answer_option: answer_option_1) }
    let!(:answer_2) { create(:answer, questionnaire: questionnaire, question: question) }
    let!(:choice_2_1) { create(:answer_choice, answer: answer_2, answer_option: answer_option_1) }

    let(:results) do
      results= Results.for(FullQuestionnaire.new(questionnaire), question)
    end

    context "with a single_option question" do
      let(:question_type) { "single_option" }

      it "generates the labels for the X axis from the answer options" do
        expect(results.x_labels).to eq([translated(answer_option_1.body), translated(answer_option_2.body), translated(answer_option_3.body)])
      end

      it "generates a single dataset with the count for each column" do
        expected= [{:data=>[2, 0, 0], :label=> I18n.t("survey_results.question_results.number_of_votes")}]

        expect(results.datasets).to eq(expected)
      end
    end

    context "with a multiple_option question" do
      let(:question_type) { "multiple_option" }
      let!(:choice_2_2) { create(:answer_choice, answer: answer_2, answer_option: answer_option_2) }

      it "generates the labels for the X axis from the answer options" do
        expect(results.x_labels).to eq([translated(answer_option_1.body), translated(answer_option_2.body), translated(answer_option_3.body)])
      end

      it "generates a single dataset with the count for each column" do
        expected= [{:data=>[2, 1, 0], :label=> I18n.t("survey_results.question_results.number_of_votes")}]

        expect(results.datasets).to eq(expected)
      end
    end
  end
end
