class Answer < ApplicationRecord
  belongs_to :question

  #Callbacks
  after_create :set_statistic

  private

  def set_statistic
    AdminStatistic.set_event(AdminStatistic::EVENTS[:total_answers])
  end
end
