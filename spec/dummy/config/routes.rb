Rails.application.routes.draw do

  mount MeterCat::Engine => '/meter_cat'

  root :to => 'root#index'
end
