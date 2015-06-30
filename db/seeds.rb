# Norm.where(test: "arm_curl", gender: "male").where("max_age >= ?", 72).where("min_age <= ?", 72)
Norm.destroy_all

[ :arm_curl, :back_scratch, :chair_stand, :eight_foot_up_and_go, :sit_and_reach, :two_minute_step].each do |test|
  [:male, :female].each do |gender|
    (60..90).step 5 do |min_age|
      max_age = min_age + 4
      scores = []
      95.step(5, -5) do |score|
        scores << score # dummy
      end
      Norm.create({test: test, gender: gender, min_age: min_age, max_age: max_age, scores: scores})
    end
  end
end
