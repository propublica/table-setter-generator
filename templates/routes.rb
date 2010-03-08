ActionController::Routing::Routes.draw do |map|
  map.table "tables/:slug/:page", :controller => :table, :action => :show
  map.root   :controller => :table, :action => :index
end