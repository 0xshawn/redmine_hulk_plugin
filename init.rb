require 'redmine'
require 'issues_patch'

Rails.configuration.to_prepare do
  #ApplicationController.send(:include, RedmineHulkPlugin::ContactsControllerPatch)
  #Contact.send(:include, RedmineHulkPlugin::Patches::Contact)
end

Redmine::Plugin.register :redmine_hulk_plugin do
  name 'Redmine Hulk Plugin'
  author 'Shown Tien'
  description 'Hulk Plugin for Redmine'
  version '0.0.2'

  url 'http://github.com/wenxer'
  author_url 'http://github.com/wenxer'

  requires_redmine :version_or_higher => '2.5.project'

  project_module :reports do
    permission :view_reports, {
      :reports => [:issue_report, :issue_report_details]
    }
    permission :view_contacts, {
      :contacts => :index
    }
  end

  menu :project_menu, :reports, { :controller => :reports, :action => :issue_report }, :caption => "Reports", :after => :activity, :params => :project_id

  Redmine::Search.available_search_types << 'contacts'
end
