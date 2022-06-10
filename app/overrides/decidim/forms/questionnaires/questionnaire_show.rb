# frozen_string_literal: true

Deface::Override.new(virtual_path: "decidim/forms/questionnaires/show",
  name: "add_button_to_questionnaire_answers",
  insert_after: "div.callout.success",
  text: "
    <%= link_to 'Ver los resultados', decidim_survey_results.survey_results_path(component_id: current_component.id) %>
  ")
