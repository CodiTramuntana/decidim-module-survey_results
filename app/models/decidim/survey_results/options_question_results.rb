# frozen_string_literal: true

module Decidim
  module SurveyResults
    class OptionsQuestionResults < Results

      def initialize(full_questionnaire, question)
        super(full_questionnaire, question, "options_question_results")
      end

      def chart_question
        labels = []
        data = []

        # labels
        question.answer_options.map do |answer_option|
          labels << translated_attribute(answer_option.body)
 
          count = 0
          full_questionnaire.answers.where(question: question).each do |answer|
            count += answer.choices.where(decidim_answer_option_id: answer_option.id).count
          end
          data << count
        end

        { labels: labels, data: data }
      end
    end
  end
end
