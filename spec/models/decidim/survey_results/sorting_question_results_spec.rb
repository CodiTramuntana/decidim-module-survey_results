# frozen_string_literal: true

require "spec_helper"

module Decidim::SurveyResults
  describe SortingQuestionResults do

    let(:question_type) { "sorting" }
    include_context "with questionnaire"
    include_context "having one question"
    include_context "having three answer options"
    include_context "having answers from two people"

    let!(:choice_1_1) { create(:answer_choice, answer: answer_1, answer_option: answer_option_1, position: 0) }
    let!(:choice_1_2) { create(:answer_choice, answer: answer_1, answer_option: answer_option_2, position: 1) }
    let!(:choice_1_3) { create(:answer_choice, answer: answer_1, answer_option: answer_option_3, position: 2) }
    let!(:choice_2_1) { create(:answer_choice, answer: answer_2, answer_option: answer_option_1, position: 0) }
    let!(:choice_2_2) { create(:answer_choice, answer: answer_2, answer_option: answer_option_2, position: 2) }
    let!(:choice_2_3) { create(:answer_choice, answer: answer_2, answer_option: answer_option_3, position: 1) }

    let(:results) do
      results= Results.for(FullQuestionnaire.new(questionnaire), question)
    end

    context "with a sorting question" do
      it "generates the labels for the X axis from the answer options" do
        expect(results.x_labels).to eq([
          I18n.t("survey_results.question_results.position", position: 1),
          I18n.t("survey_results.question_results.position", position: 2),
          I18n.t("survey_results.question_results.position", position: 3),
        ])
      end

      it "generates a single dataset with the count for each column" do
        expected= [
          {:data=>[2, 0, 0], :label=> translated(answer_option_1.body)},
          {:data=>[0, 1, 1], :label=> translated(answer_option_2.body)},
          {:data=>[0, 1, 1], :label=> translated(answer_option_3.body)},
        ]

        expect(results.datasets).to eq(expected)
      end
    end
  end
end
