# -*- coding: utf-8 -*-
class Contact < ActiveRecord::Base
  unloadable

  belongs_to :issue
  belongs_to :project
  has_many :player

  acts_as_event :title => Proc.new {|o| "渠道: #{o.channel} 渠道账户: #{o.channel_account}"},
  :url => Proc.new {|o| {:controller => 'issues', :action => 'show', :id => Issue.find(:all, :conditions => {:contact_id => o.id}).first.id}},
  :description => Proc.new { |o| "账户: #{o.account}, 角色名: #{o.role_name}, Email: #{o.email}, 电话: #{o.phone}" },
  :datetime => :created_on

  acts_as_searchable :columns => ['channel', "channel_account", "account", "role_name", "email", "phone"],
  :project_key => :project_id,
  :include => :project,
  :order_column => "#{table_name}.id",
  :permission => :view_contacts

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
