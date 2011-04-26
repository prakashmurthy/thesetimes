Thesetimes::Application.routes.draw do
  match "/:key", :to => "timeset#view", :as => "short"  
  root :to => "timeset#view"
end
