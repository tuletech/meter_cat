FactoryGirl.define do

  factory :user_created_1, :class => MeterCat::Meter do
    name 'user_created'
    value 2
    created_on Date.civil( 2013, 9, 1 )
  end

  factory :user_created_2, :class => MeterCat::Meter do
    name 'user_created'
    value 4
    created_on Date.civil( 2013, 9, 2 )
  end

  factory :user_created_3, :class => MeterCat::Meter do
    name 'user_created'
    value 16
    created_on Date.civil( 2013, 9, 3 )
  end

  factory :login_failed_3, :class => MeterCat::Meter do
    name 'login_failed'
    value 1
    created_on Date.civil( 2013, 9, 3 )
  end

end