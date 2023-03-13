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

      def compute_results
        {labels: [], datasets: []}
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
