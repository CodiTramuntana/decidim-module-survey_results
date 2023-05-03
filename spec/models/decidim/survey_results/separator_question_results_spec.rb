# frozen_string_literal: true

require "spec_helper"

module Decidim::SurveyResults
  describe SeparatorQuestionResults do

    let(:question_type) { "separator" }
    include_context "with questionnaire"
    include_context "having one question"

    let(:results) do
      results= Results.for(FullQuestionnaire.new(questionnaire), question)
    end

    context "with a separator question" do
      it "generates empty labels for the X axis" do
        expect(results.x_labels).to be nil
      end

      it "generates a nil dataset" do
        expect(results.datasets).to be nil
      end
    end
  end
end
