class Norm < ActiveRecord::Base
  validate :valid_scores

  def percentile(raw_score)
    return nil if raw_score == nil
    best_diff = 1000
    best_index = -1
    matches = []
    scores.each_with_index do |score, i|
      diff = (score-raw_score).abs
      if diff <= best_diff
        best_diff = diff
        best_index = i
        matches << percentile_from_index(i) if best_diff == 0
      end
    end
    return percentile_from_index(best_index) if best_diff != 0
    avg_match = matches.reduce(:+) / matches.size
  end

  private

  def percentile_from_index(i)
    95 - (5*i)
  end

  def valid_scores
    scores.each_with_index do |score, i|
      if score == nil
        errors.add(:scores, "Scores may not be nil")
        return false
      end
      if test == "eight_foot_up_and_go"
        if i>0 && score < scores[i-1]
          errors.add(:scores, "Scores must be ascending")
          return false
        end
      else
        if i>0 && score > scores[i-1]
          errors.add(:scores, "Scores must be descending")
          return false
        end
      end
    end
  end
end
