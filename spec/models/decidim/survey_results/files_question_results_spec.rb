# frozen_string_literal: true

require "spec_helper"

module Decidim::SurveyResults
  describe FilesQuestionResults do

    let(:question_type) { "files" }
    include_context "with questionnaire"
    include_context "having one question"
    include_context "having three answer options"
    let!(:answer_1) { create(:answer, questionnaire: questionnaire, question: question) }

    let!(:file_1_1) do
      test_file= upload_test_file(Decidim::Dev.test_file("Exampledocument.pdf", "application/pdf"))
      answer_1.attachments.create!(
          title: {en: "file_1_1.pdf"},
          file: test_file,
          content_type: "application/pdf"
        )
    end

    let(:results) do
      results= Results.for(FullQuestionnaire.new(questionnaire), question)
    end

    context "with a files question" do
      it "generates the hardcoded labels for the X axis" do
        expect(results.x_labels).to eq([
            I18n.t("survey_results.question_results.answered"),
            I18n.t("survey_results.question_results.not_answered")
          ])
      end

      it "generates a single dataset with the count of users that have and have not answered the question" do
        expected= [{data: [1, 0]}]

        expect(results.datasets).to eq(expected)
      end
    end
  end
end
