# frozen_string_literal: true

module Decidim
  module SurveyResults
    class SortingQuestionResults < Results

      def initialize(full_questionnaire, question)
        super(full_questionnaire, question, "sorting_question_results")
      end

      #---------------------------------------------------------------

      private

      #---------------------------------------------------------------

      # labels: I18n position names, same number as available options to order.
      # datasets: Each dataset is an Array where each item is the number of choices for the given option in that position.
      def compute_results
        user_question_answers= full_questionnaire.answers
        choices_sums= Decidim::Forms::AnswerChoice.where("decidim_answer_id IN (#{user_question_answers.select(:id).where(question: question).to_sql})").group(:decidim_answer_option_id, :position).count

        labels= []
        datasets= []
        positions= 0...question.answer_options.size
        question.answer_options.each_with_index do |answer_option, idx|
          position= idx + 1
          labels << I18n.t("survey_results.question_results.position", position: position)

          values= positions.map {|n| choices_sums[[answer_option.id, n]] || 0}
          datasets << {label: translated_attribute(answer_option.body), data: values}
        end

        {labels: labels, datasets: datasets}
      end

      def sorting_question(question)
        positions = question.answer_options.count
        values = []
        all_data = []

        counts = []
        question.answer_options.map do |answer_option|
          values << translated_attribute(answer_option.body)
 
          answers.where(question: question).each do |answer|
            positions_count = []
            positions.times do |position|
              positions_count << {position: position, position_count: 0}
            end

            
            choice = answer.choices.find_by(decidim_answer_option_id: answer_option.id)
            position_choice = choice.position
            data = {choice: answer_option.id, positions_count: positions_count}
          
            positions.times do |position|
              if position_choice == position
                data[:positions_count][position][:position_count] += 1
              end
            end
            all_data << data
          end
        end

        { positions: positions, values: values, data: data }
      end

    end
  end
end
