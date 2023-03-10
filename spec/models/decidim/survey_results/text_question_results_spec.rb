# frozen_string_literal: true

require "spec_helper"

module Decidim::SurveyResults
  describe TextQuestionResults do

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

    context "with a short_answer question" do
      let(:question_type) { "short_answer" }

      it "generates the hardcoded labels for the X axis" do
        expect(results.x_labels).to eq([
            I18n.t("survey_results.question_results.answered"),
            I18n.t("survey_results.question_results.not_answered")
          ])
      end

      it "generates a single dataset with the count of users that have and have not answered the question" do
        expected= [{data: [2, 0]}]

        expect(results.datasets).to eq(expected)
      end
    end

    context "with a long_answer question" do
      let(:question_type) { "long_answer" }
      let!(:answer_3) { create(:answer, questionnaire: questionnaire, question: question) }

      it "generates the hardcoded labels for the X axis" do
        expect(results.x_labels).to eq([
            I18n.t("survey_results.question_results.answered"),
            I18n.t("survey_results.question_results.not_answered")
          ])
      end

      it "generates a single dataset with the count for each column" do
        expected= [{data: [3, 0]}]

        expect(results.datasets).to eq(expected)
      end
    end
  end
end
