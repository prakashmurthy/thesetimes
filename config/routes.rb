Thesetimes::Application.routes.draw do
  match "/:key", :to => "timesets#view", :as => "short", :via => :get
  match "/:key/sections", :to => "sections#index", :via => :get
  match "/sections", :to => "sections#create", :via => :post
  match "/sections", :to => "sections#destroy", :via => :delete
  root :to => "timesets#view"
end
