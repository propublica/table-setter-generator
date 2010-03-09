require 'table_setter'
class TableSetterGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      
      # Model
      m.directory "app/models/"
      m.file "table.rb", "app/models/table.rb"
      
      
      # Views
      m.directory "app/views/table/"
      m.file "ts/views/index.erb", "app/views/table/index.erb"
      m.file "ts/views/table.erb", "app/views/table/table.erb"
      
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
             "public/stylesheets/stylesheet.css"
      
      m.directory "public/images"
      ["th_arrow_asc.gif", "th_arrow_desc.gif"].each do |image|
        m.file "ts/public/images/#{image}", "public/images/#{image}"
      end
      
      # TableSetter Config Files
      m.directory "config/tables"
      ["example.yml", "example_faceted.yml", "example_formatted.csv", 
        "example_formatted.yml", "example_local.csv", "example_local.yml"].each do |table|
        m.file "ts/tables/#{table}", "config/tables/#{table}"
      end
      
      # Local Installs
      m.directory "app/controllers/"
      m.file "table_controller.rb", "app/controllers/table_controller.rb"
      
      # File changes
      m.route! 'map.table ":slug/:page", :controller => :table, :action => :table, :requirements => { :page => /\d+/}, :page => nil'
      m.route! "map.expire ':slug/expire', :controller => :table, :action => :expire"
      m.route! "map.root :controller => :table, :action => :index"
      

      m.config! "config.gem 'table_setter'"
      m.config! "config.frameworks -= [ :active_record, :active_resource, :action_mailer ]"

      
      # Environment
      m.gsub_file "config/environment.rb", /(\z)/m do |match|
        "\n" + 'TableSetter.configure "#{RAILS_ROOT}/config/"'
      end
      
      
      # Sinatra to Rails
      m.gsub_file "app/views/layouts/table.erb", /(javascript_script_tag)/m do |match|
        "javascript_include_tag"
      end
      
      m.gsub_file "app/views/layouts/table.erb", /(\/javascripts\/|\/stylesheets\/)/m do |match|
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
