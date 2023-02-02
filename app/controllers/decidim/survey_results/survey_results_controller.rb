# frozen_string_literal: true

module Decidim
  module SurveyResults
    class SurveyResultsController < Decidim::ApplicationController
      include Decidim::ApplicationHelper

      helper_method :question_answer_labels, :question_answer_data

      def index
        @questions = Decidim::Forms::Question.where(questionnaire: questionnaire)
        @answers = Decidim::Forms::Answer.not_separator
                .joins(:question)
                .where(questionnaire: questionnaire)
        @num_answers= @questions.first.answers_count
      end

      private

      def component
        @component ||= Decidim::Component.find(params[:component_id])
      end

      def survey
         @questionnaire ||= ::Decidim::Surveys::Survey.find_by(component: component)
      end

      def questionnaire
         @questionnaire ||= ::Decidim::Forms::Questionnaire.find_by(questionnaire_for: survey)
      end

      def question_answer_labels(question)
        question.answer_options.map do |answer_option|
          translated_attribute(answer_option.body)
        end
      end

      def question_answer_data(question)
        case question.question_type
        when "single_option"
          single_option_question(question)
        when "short_answer"
          questionnaire.answers.where(question: question).map do |answer|
            [
              answer.body,
              Decidim::Forms::AnswerChoice.where(answer: answer).count
            ]
          end
        end
      end

      def single_option_question(question)
        [3,2,5]
      end
    end
  end
end
