require 'redmine'
require 'issues_controller_patch'

Rails.configuration.to_prepare do
  ApplicationController.send(:include, RedmineHulkPlugin::IssuesControllerPatch)
end

Redmine::Plugin.register :redmine_hulk_plugin do
  name 'Redmine Hulk Plugin'
  author 'Shown Tien'
  description 'Hulk Plugin for Redmine'
  version '0.0.1'
  url 'http://github.com/wenxer'
  author_url 'http://github.com/wenxer'

  requires_redmine :version_or_higher => '2.5.0'

  menu( :top_menu,
    :issue_reports,
    { :controller => 'issues', :action => 'reports' },
    :caption => 'Reports',
    )

  project_module :reports do
    permission :issues_reports, {
      :issues => [:index, :reports]
    }
  end
  menu :project_menu, :issues_reports, { :controller => 'reports', :action => 'issue_report' }, :caption => "Reports", :after => :activity, :param => :project_id
end
