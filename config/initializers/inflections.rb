# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.plural 'person_podcast', 'people_podcasts'
  inflect.singular 'people_podcasts', 'person_podcast'
  inflect.plural 'company_podcast', 'companies_podcasts'
  inflect.singular 'companies_podcasts', 'company_podcast'
  inflect.plural 'company_person', 'companies_people'
  inflect.singular 'companies_people', 'company_person'
end
