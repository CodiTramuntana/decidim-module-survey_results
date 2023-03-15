# frozen_string_literal: true

require "spec_helper"

module Decidim::SurveyResults
  shared_context "with questionnaire" do

    let(:current_organization) { create(:organization) }
    let(:participatory_process) { create(:participatory_process, organization: current_organization) }
    let(:questionnaire) { create(:questionnaire, questionnaire_for: participatory_process) }
  end

  shared_context "having one question" do
    let(:question) do
      create(:questionnaire_question,
              question_type: question_type,
              position: 1,
              questionnaire: questionnaire)
    end
  end

  shared_context "having three answer options" do
    let!(:answer_option_1) { create(:answer_option, question: question) }
    let!(:answer_option_2) { create(:answer_option, question: question) }
    let!(:answer_option_3) { create(:answer_option, question: question) }
  end

  shared_context "having answers from two people" do
    let!(:answer_1) { create(:answer, questionnaire: questionnaire, question: question) }
    let!(:answer_2) { create(:answer, questionnaire: questionnaire, question: question) }
  end

end
