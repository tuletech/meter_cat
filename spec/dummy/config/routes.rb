Rails.application.routes.draw do

  mount MeterCat::Engine => '/meter_cat'
  mount StatusCat::Engine => '/status_cat'

  root :to => 'root#index'
  get '/mail' => 'root#mail'

end
