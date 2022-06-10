# frozen_string_literal: true

Deface::Override.new(virtual_path: "decidim/forms/questionnaires/show",
  name: "add_button_to_questionnaire_answers",
  insert_after: "div.callout.success",
  text: "
    <%= link_to 'Ver los resultados', Decidim::EngineRouter.main_proxy(current_component).survey_results_path %>
  ")
