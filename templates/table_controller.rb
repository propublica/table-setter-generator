class TableController < ApplicationController
  caches_page :index, :table
  def index
    expires_in TableSetter::App.cache_timeout.minutes
    if stale? :last_modified => Table.fresh_yaml_time, :public => true
      @tables = Table.all
    end
  end
  
  def table
    @table = Table.new(params[:slug])
    expires_in TableSetter::App.cache_timeout.minutes
    if stale? :last_modified => Time.parse(@table.updated_at), :public => true
      @table.load
      page = params[:page] || 1
      @table.paginate! page
    end
  end
  
  def expire
    table = Table.new(params[:slug])
    cache_dir = ActionController::Base.page_cache_directory
    FileUtils.rm_r(Dir.glob(cache_dir + "/#{table.slug}.html")) rescue Errno::ENOENT
    FileUtils.rm_r(Dir.glob(cache_dir + "/#{table.slug}")) rescue Errno::ENOENT
    redirect_to :action => :index
  end
end