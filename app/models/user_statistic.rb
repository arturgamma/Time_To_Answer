class UserStatistic < ApplicationRecord
    belongs_to :user

    # Virtual attributes
    def total_questions
        self.right_questions + self.wrong_questions
    end
    #Class Method/Método de classe
    def self.set_statistic(answer)
        if user_signed_in?
            user_statistic = UserStatistic.find_or_create_by(user: current_user)
            answer.correct? ? user_statistic.increment!(:right_questions) : user_statistic.increment!(:wrong_questions)
            user_statistic.save
        end    
    end 

end
