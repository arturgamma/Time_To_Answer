class AdminStatistic < ApplicationRecord
    EVENTS = {
        total_users: "TOTAL_USERS",
        total_questions: "TOTAL_QUESTIONS", 
        total_answers: "TOTAL_ANSWERS"
    }
    def self.set_event(event)
        admin_statistic = AdminStatistic.find_or_create_by(event: event)
        admin_statistic.value += 1
        admin_statistic.save
    end

end
