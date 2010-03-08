class TableSetterGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      
      # Model
      m.directory "app/models/"
      m.file "templates/table.rb", "app/models/table.rb"
      
      # Views
      m.directory "app/views/table/"
      ["index.erb", "table.erb"].each do |f|
        m.file "#{TableSetter::ROOT}/template/views/#{f}", "app/views/table/#{f}"
      end
      
      # Layout
      m.directory "app/views/layout/"
      m.file "#{TableSetter::ROOT}/template/layout.erb", "app/views/layouts/table.erb"
      
      # Static Assets
      m.directory "public/javascripts/"
      ["application.js", "jquery.tablesorter.js", 
        "jquery.tablesorter.multipagefilter.js", "jquery.tablesorter.pager.js"].each do |js|
        m.file "#{TableSetter::ROOT}/template/javascripts/#{js}", "public/javascripts/#{js}"
      end
      
      m.directory "public/stylesheets"
      m.file "#{TableSetter::ROOT}/template/stylesheets/stylesheet.css",
             "public/stylesheets/application.css"
      
      m.directory "public/images"
      ["th_arrow_asc.gif", "th_arrow_desc.gif"].each do |image|
        m.file "#{TableSetter::ROOT}/template/images/#{image}", "public/images/#{image}"
      end
      
      # Local Installs
      m.directory "app/controllers/"
      m.file "templates/table_controller.rb", "app/controllers/table_controller.rb"
      
      m.directory "app/helpers/"
      m.file "templates/application_helper.rb", "app/helpers/application_helper.rb"
      

      
      route! "map.table \"tables/:slug/:page\", :controller => :table, :action => :show"
      route! "map.root   :controller => :table, :action => :index"
      
      environment! "production.rb", <<-EOS
TableSetter::App.cache_timeout = 15.minutes
config.middleware.use Rack::Cache,
      :metastore   => "file:/#{RAILS_ROOT}/tmp/meta",
      :entitystore => "file:/#{RAILS_ROOT}/tmp/body"
EOS
      config! "config.gem 'table_setter'"
      config! "config.frameworks -= [ :active_record, :active_resource, :action_mailer ]"
    end
  end
  
  def environment!(file, string)
    insert_string! file, string, "$"
  end
  
  def config!(string)
    insert_string! "config/environment.rb", string, 
      "Rails::Initializer.run do |config|"
  end
  
  def route!(string)
    insert_string! "config/routes.rb", string, 
      "ActionController::Routing::Routes.draw do |map|"
  end
  
private

  def insert_string!(file, string, insert_after)
    gsub_file file, string, /(#{insert_after})/mi do |match|
      "#{match}\n #{string}"
    end
  end
  
end