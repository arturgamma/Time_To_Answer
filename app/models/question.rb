class Question < ApplicationRecord
  belongs_to :subject, counter_cache: true,  inverse_of: :questions #belongs_to => pertence a // counter_cache => contador de cache
  # add counter_cache: rails g migration AddQuenstionsCountToSubjects
  has_many :answers
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  #Kaminari
  paginates_per 5
  #querys(pesquisas)
  scope :_search_, ->(page, term){
    includes(:answers, :subject)
    .where("lower(description) LIKE ?", "%#{term.downcase}%")
    .page(page)
  }

   scope :_search_subject_, ->(page, subject_id){
    includes(:answers, :subject)
    .where(subject_id: subject_id)
    .page(page)
  }
  
  scope :last_questions, -> (page){
   includes(:answers, :subject).order('created_at desc').page(page)
  }  
end
