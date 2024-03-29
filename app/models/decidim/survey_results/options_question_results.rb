# frozen_string_literal: true

module Decidim
  module SurveyResults
    class OptionsQuestionResults < Results

      def initialize(full_questionnaire, question)
        super(full_questionnaire, question, "options_question_results")
      end

      #-----------------------------------------------

      private

      #-----------------------------------------------

      # labels: each anwer_option/column is a label.
      # datasets: Returns only one dataset with the results of each column.
      def compute_results
        user_question_answers= full_questionnaire.answers
        choices_sums= Decidim::Forms::AnswerChoice.where("decidim_answer_id IN (#{user_question_answers.select(:id).where(question: question).to_sql})").group(:decidim_answer_option_id).count

        x_labels = []
        dataset = {label: I18n.t("survey_results.question_results.number_of_votes"), data: []}
        question.answer_options.map do |answer_option|
          x_labels << translated_attribute(answer_option.body)

          dataset[:data] << (choices_sums[answer_option.id] || 0)
        end

        { labels: x_labels, datasets: [dataset] }
      end
    end
  end
end
