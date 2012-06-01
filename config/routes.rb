EdbookfestMobile::Application.routes.draw do
  
  match "events/calendar" => "events#calendar", :as => :calendar
  match "coming" => "events#coming", :as => :coming
  match "events/calendar/:date(/:type)" => "events#index", :as => :listings, :constraints => { :date => /\d{4}-\d{2}-\d{2}/, :type => /(Adult|Children)/ }
  
  resources :events, :only => [:index, :show]
  resources :authors, :only => [:show] do 
    resources :articles, :only => [:index] do
      member do
        get :show, :constraints => {:id => /.*/ }
      end
    end
  end
  resources :books, :only => [:show]
  
  match "time/set/:day/:hour/:minute" => "time#set"
  match "time/reset" => "time#reset"
  
  match "settings/dates" => "settings#dates", :as => :settings_dates
  
  root :to => 'events#index'

end
