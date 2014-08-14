module RedmineHulkPlugin
  module IssuesControllerPatch
    def self.included(base)
      base.class_eval do
        # add a new action: :reports
        def reports
          logger.debug "######### Redmine Plugin"
          @project_id = params[:project_id]
          logger.debug "@project_id: #{@project_id}"
          case params[:q]
          when 'authors'
            @issues = Issue.issues_grouped_by_authors(@project_id)
          when 'assignees'
            @issues = Issue.issues_grouped_by_assignees(@project_id)
          when 'trackers'
            @issues = Issue.issues_grouped_by_issue_trackers(@project_id)
          when 'issue_status'
            @issues = Issue.issues_grouped_by_status(@project_id)
          when 'categories'
            @issues = Issue.issues_grouped_by_categories(@project_id)
          when 'projects'
            @projects = Issue.issues_grouped_by_projects
          else
            @projects = Issue.issues_grouped_by_projects
          end
          @type = params[:q]
          respond_to do |format|
            format.html {
              render :template => 'issues/reports'
            }
          end
        end
      end
    end
  end
end
