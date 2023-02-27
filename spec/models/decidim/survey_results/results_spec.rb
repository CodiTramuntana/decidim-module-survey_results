# frozen_string_literal: true

require "spec_helper"

module Decidim::SurveyResults
  describe Results do

    let(:current_organization) { create(:organization) }
    let(:participatory_process) { create(:participatory_process, organization: current_organization) }
    let(:questionnaire) { create(:questionnaire, questionnaire_for: participatory_process) }

    describe "#for" do
      let(:question) do
        create(:questionnaire_question,
                question_type: question_type,
                position: 1,
                questionnaire: questionnaire)
      end
      let(:results) do
        results= Results.for(FullQuestionnaire.new(questionnaire), question)
      end

      %w(single_option multiple_option).each do |type|
        context "when building a #{type} question type" do
          let(:question_type) { type }

          it "creates the correct Response" do
            expect(results.class).to eq(OptionsQuestionResults)
            expect(results.partial_name).to eq("options_question_results")
            expect(results.question).to eq(question)
            expect(results.question_type).to eq(question_type)
          end
        end
      end

      %w(short_answer long_answer).each do |type|
        context "when building a #{type} question type" do
          let(:question_type) { type }

          it "creates the correct Response" do
            expect(results.class).to eq(TextQuestionResults)
            expect(results.partial_name).to eq("text_question_results")
            expect(results.question).to eq(question)
            expect(results.question_type).to eq(question_type)
          end
        end
      end

      context "when building a files question type" do
        let(:question_type) { "files" }

        it "creates the correct Response" do
          expect(results.class).to eq(FilesQuestionResults)
          expect(results.partial_name).to eq("files_question_results")
          expect(results.question).to eq(question)
          expect(results.question_type).to eq(question_type)
        end
      end

      context "when building a matrix_single question type" do
        let(:question_type) { "matrix_single" }

        it "creates the correct Response" do
          expect(results.class).to eq(MatrixQuestionResults)
          expect(results.partial_name).to eq("matrix_question_results")
          expect(results.question).to eq(question)
          expect(results.question_type).to eq(question_type)
        end
      end

      context "when building a sorting question type" do
        let(:question_type) { "sorting" }

        it "creates the correct Response" do
          expect(results.class).to eq(SortingQuestionResults)
          expect(results.partial_name).to eq("sorting_question_results")
          expect(results.question).to eq(question)
          expect(results.question_type).to eq(question_type)
        end
      end
    end
  end
end
