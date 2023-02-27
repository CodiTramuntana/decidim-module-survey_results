# frozen_string_literal: true

# Extends the Decidim::Surveys component.

component = Decidim.find_component_manifest :surveys
component.settings(:global).attribute(:enable_results, type: :boolean, default: false)
