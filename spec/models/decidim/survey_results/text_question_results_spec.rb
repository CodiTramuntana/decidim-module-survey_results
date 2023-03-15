# frozen_string_literal: true

require "spec_helper"

module Decidim::SurveyResults
  describe TextQuestionResults do

    let(:question_type) { "short_answer" }
    include_context "with questionnaire"
    include_context "having one question"
    include_context "having three answer options"

    let(:results) do
      results= Results.for(FullQuestionnaire.new(questionnaire), question)
    end

    context "without answers" do
      describe "#answered_percentage" do
        it "returns zero" do
          expect(results.answered_percentage).to eq(0)
        end
      end
      describe "#not_answered_percentage" do
        it "returns zero" do
          expect(results.not_answered_percentage).to eq(0)
        end
      end
    end

    context "with answers" do
      include_context "having answers from two people"
      let!(:choice_1_1) { create(:answer_choice, answer: answer_1, answer_option: answer_option_1) }
      let!(:choice_2_1) { create(:answer_choice, answer: answer_2, answer_option: answer_option_1) }

      context "with a short_answer question" do
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
end
