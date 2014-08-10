Redmine::Plugin.register :redmine_issue_reports do
  name 'Redmine Issue Reports plugin'
  author 'Shown Tien'
  description 'Redmine Issue Reports'
  version '0.0.1'
  url 'http://github.com/wenxer'
  author_url 'http://github.com/wenxer'

  requires_redmine :version_or_higher => '2.5.0'

  menu( :top_menu,
    :issue_reports,
    { :controller => 'issues', :action => 'reports' },
    :caption => 'Reports',
    )

  permission :issues_reports, { :issues => [:index, :reports] }, :public => false
  menu :project_menu, :issues_reports, { :controller => 'issues', :action => 'reports' }, :caption => "Reports", :after => :activity, :param => :project_id
end
