require 'table_setter'
class TableSetterGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      
      # Model
      m.directory "app/models/"
      m.file "table.rb", "app/models/table.rb"
      
      
      # Views
      m.directory "app/views/table/"
      ["index.erb", "table.erb"].each do |f|
        m.file "ts/views/#{f}", "app/views/table/#{f}"
      end
      
      # Layout
      m.directory "app/views/layouts/"
      m.file "ts/views/layout.erb", "app/views/layouts/table.erb"
      
      # Static Assets
      m.directory "public/javascripts/"
      ["application.js", "jquery.tablesorter.js", 
        "jquery.tablesorter.multipagefilter.js", "jquery.tablesorter.pager.js"].each do |js|
        m.file "ts/public/javascripts/#{js}", "public/javascripts/#{js}"
      end
      
      m.directory "public/stylesheets"
      m.file "ts/public/stylesheets/stylesheet.css",
             "public/stylesheets/application.css"
      
      m.directory "public/images"
      ["th_arrow_asc.gif", "th_arrow_desc.gif"].each do |image|
        m.file "ts/public/images/#{image}", "public/images/#{image}"
      end
      
      # TableSetter Config Files
      m.directory "config/tables"
      ["example.yml", "example_facted.yml", "example_formatted.csv", 
        "example_fomatted.yml", "example_local.csv", "example_local.yml"].each do |table|
        m.file "ts/tables/#{table}", "config/tables/#{table}"
      end
      
      # Local Installs
      m.directory "app/controllers/"
      m.file "table_controller.rb", "app/controllers/table_controller.rb"
      
      # File changes
      m.route! "map.table \"tables/\", :controller => :table, :action => :show"
      m.route! "map.root   :controller => :table, :action => :index"
      
      m.environment! "production.rb", <<-EOS
TableSetter::App.cache_timeout = 15.minutes
config.middleware.use Rack::Cache,
      :metastore   => "file:/#{RAILS_ROOT}/tmp/meta",
      :entitystore => "file:/#{RAILS_ROOT}/tmp/body"
EOS
      m.config! "config.gem 'table_setter'"
      m.config! "config.frameworks -= [ :active_record, :active_resource, :action_mailer ]"
      m.environment! "production.rb",  'TableSetter.config_path "#{RAILS_ROOT}/config/tables/"'
      m.environment! "environment.rb", 'TableSetter.config_path "#{RAILS_ROOT}/config/tables/"'
      
      
      # Sinatra to Rails
      m.gsub_file "app/views/layouts/layout.erb", /(javascript_script_tag)/m do |match|
        "javascript_include_tag"
      end
      
      m.gsub_file "app/views/layouts/layout.erb", /(#{Regexp.escape "\"/javascripts/"})/m do |match|
        ""
      end
      
      m.gsub_file "app/views/table/table.erb", /(#{Regexp.escape '<%= url_for "/#{table.slug}/#{table.prev_page}/" if !table.prev_page.nil? %>'})/m do |match|
        '<%= url_for(table_path :slug => table.slug, :page => table.prev_page) if !table.prev_page.nil? %>'
      end
      m.gsub_file "app/views/table/table.erb", /(#{Regexp.escape '<%= url_for "/#{table.slug}/#{table.next_page}/" if !table.next_page.nil? %>'})/m do |match|
        '<%= url_for(table_path :slug => table.slug, :page => table.next_page) if !table.next_page.nil? %>'
      end
      m.gsub_file "app/views/table/index.erb", /(#{Regexp.escape '<%= url_for "/#{table.slug}/" %>'})/ do |match|
        '<%= url_for(table_path :slug => table.slug) %>'
      end
    end
  end
end


Rails::Generator::Commands::Create.class_eval do
 def environment!(file, string)
    insert_string! "config/environments/#{file}", string, "$"
  end
  
  def config!(string)
    insert_string! "config/environment.rb", string, 
      "Rails::Initializer.run do |config|"
  end
  
  def route!(string)
    insert_string! "config/routes.rb", string, 
      "ActionController::Routing::Routes.draw do |map|"
  end
  

  def insert_string!(file, string, insert_after)
    gsub_file file, /(#{Regexp.escape(insert_after)})/mi do |match|
      "#{match}\n #{string}"
    end
  end
end
