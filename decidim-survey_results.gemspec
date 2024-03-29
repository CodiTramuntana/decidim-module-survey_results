# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require "decidim/survey_results/version"

Gem::Specification.new do |s|
  s.version = Decidim::SurveyResults.version
  s.authors = ["Laura Jaime", "Oliver Valls"]
  s.email = ["199462+tramuntanal@users.noreply.github.com"]
  s.license = "AGPL-3.0"
  s.homepage = "https://github.com/decidim/decidim-module-survey_results"
  s.required_ruby_version = ">= 3.1"

  s.name = "decidim-survey_results"
  s.summary = "A decidim survey_results module"
  s.description = "This module enables the admins to show survey results to participants though a new survey results page.."

  s.files = Dir["{app,config,lib}/**/*", "LICENSE-AGPLv3.txt", "Rakefile", "README.md"]

  s.add_dependency "decidim-core", ">=#{Decidim::SurveyResults.min_decidim_version}"
  s.add_dependency "decidim-forms", ">=#{Decidim::SurveyResults.min_decidim_version}"
  s.add_dependency "decidim-surveys", ">=#{Decidim::SurveyResults.min_decidim_version}"
  s.add_dependency "deface"

  s.add_development_dependency "decidim", ">=#{Decidim::SurveyResults.min_decidim_version}"
  s.add_development_dependency "decidim-dev", ">=#{Decidim::SurveyResults.min_decidim_version}"
end
