class Interval < ActiveRecord::Base

  scope :bydate, ->{order(:interval_start)}
  scope :show_months, ->(period_months) {where('interval_start > ?', Time.now-period_months.to_i)}

  #scope the information by seasons so we can aggregate the values
  #problem in PG with MONTH -
  scope :summer, ->{where('MONTH(interval_start) in (?)', [7,8,9]) }
  scope :fall,   ->{where('MONTH(interval_start) in (?)', [10,11,12]) }
  scope :winter, ->{where('MONTH(interval_start) in (?)', [1,2,3]) }
  scope :spring, ->{where('MONTH(interval_start) in (?)', [4,5,6]) }
  scope :current_year, ->{where('interval_start > ?', Time.now - 365.days  )}
  scope :base_load, ->{where('HOUR(interval_start) in (?)',[0,1,2,3,4,5]) }
end


