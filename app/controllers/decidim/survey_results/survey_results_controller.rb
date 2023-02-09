# frozen_string_literal: true

module Decidim
  module SurveyResults
    class SurveyResultsController < Decidim::ApplicationController
      include Decidim::ApplicationHelper
      include Decidim::SurveyResults::SurveyResultsHelper

      helper_method :question_answer_labels,
                    :question_answer_data,
                    :question_answers,
                    :total_countable_answers_count,
                    :total_answers_files_count,
                    :total_answers,
                    :chart_question

      def index
        @questions = Decidim::Forms::Question.where(questionnaire: questionnaire)
        @answers = answers
        @num_answers= @questions.first.answers_count
        @participants = participants
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

      def participants
        @participants ||= ::Decidim::Forms::QuestionnaireParticipants.new(questionnaire).participants
      end

      def answers
        @answers ||= Decidim::Forms::Answer.not_separator
                           .not_title_and_description
                           .joins(:question)
                           .where(questionnaire: questionnaire)
      end

      def total_answers(question)
        answers.where(question: question).count
      end

      def question_answer_labels(question)
        question.answer_options.map do |answer_option|
          translated_attribute(answer_option.body)
        end
      end

      def question_answer_data(question)
        case question.question_type
        when "single_option", "multiple_option"
          chart_question(question)
        when "short_answer"
          questionnaire.answers.where(question: question).map do |answer|
            [
              answer.body,
              Decidim::Forms::AnswerChoice.where(answer: answer).count
            ]
          end
        end
      end

      def total_countable_answers_count(question)
        answers.where(question: question).where.not(body: "").count
      end

      def total_answers_files_count(question)
        total_answers_files = {
          with_attachments: 0,
          without_attachments: 0
        }
        
        answers.where(question: question).each do |answer|
          if answer.attachments.present?
            total_answers_files[:with_attachments] += 1
          else
            total_answers_files[:without_attachments] += 1
          end
        end

        total_answers_files
      end

      def chart_question(question)
        labels = []
        data = []

        # labels
        question.answer_options.map do |answer_option|
          labels << translated_attribute(answer_option.body)
 
          count = 0
          answers.where(question: question).each do |answer|
            count += answer.choices.where(decidim_answer_option_id: answer_option.id).count
          end
          data << count
        end

        { labels: labels, data: data }
      end
    end
  end
end
