# frozen_string_literal: true

require "spec_helper"

module Decidim::SurveyResults
  describe Results do

    let(:question_type) { "sorting" }
    include_context "with questionnaire"

    describe "#for" do
      include_context "having one question"

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

      context "when building a separator question type" do
        let(:question_type) { "separator" }

        it "creates the correct Response" do
          expect(results.class).to eq(SeparatorQuestionResults)
          expect(results.partial_name).to eq("separator_question_results")
          expect(results.question).to eq(question)
          expect(results.question_type).to eq(question_type)
        end
      end
    end
  end
end
