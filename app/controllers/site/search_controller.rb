class Site::SearchController < SiteController
  def questions
    @questions = Question.all
  end
end
