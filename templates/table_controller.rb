class TableController < ApplicationController
  
  def index
    expires_in TableSetter.cache_timeout.minutes
    if stale? :last_modified => Table.fresh_yaml_time, :public => true
      tables = Table.all
    end
  end
  
  def table
    table = Table.new(params[:slug])
    expires_in TableSetter.cache_timeout.minutes
    if stale? :last_modified => table, :public => true
      table.load
      page = params[:page] || 1
      table.paginate! page
    end
  end

end