# -*- coding: utf-8 -*-
module RedmineHulkPlugin
  module Patches
    module Contact

      def self.included(base)
        base.class_eval do
          unloadable

          acts_as_searchable :columns => ['channel', "channel_account", "account", "role_name", "email", "phone"],
          :include => :project,
          # sort by id so that limited eager loading doesn't break with postgresql
          :order_column => "#{table_name}.id"

          acts_as_event :title => Proc.new {|o| "渠道: #{o.channel} 渠道账户: #{o.channel_account}"},
          :url => Proc.new {|o| {:controller => 'issues',
              :action => 'show',
              :id => Issue.find(:all, :conditions => {:contact_id => o.id}).first.id}},
          :description => Proc.new { |o| "账户: #{o.account}, 角色名: #{o.role_name}, Email: #{o.email}, 电话: #{o.phone}" }
          #:type => Proc.new {|o| 'issue' + (o.closed? ? ' closed' : '') }

          #acts_as_activity_provider :find_options => {:include => :project},
          #:author_key => :author_id,
          #:type => 'kb_articles',
          #:timestamp => :updated_at

          #scope :visible, lambda {|*args|
          #  includes(:project)
          #}
          #
          #def visible?(user=User.current)
          #  true
          #end
        end
      end
    end
  end
end
