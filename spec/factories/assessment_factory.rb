FactoryGirl.define do

  factory :assessment do
    assessor
    resident
    date Date.today
    chair_stand 14
    arm_curl 18
    two_minute_step 70
    sit_and_reach 0.5
    back_scratch -1.5
    eight_foot_up_and_go 6.1
  end
end
