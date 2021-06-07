class Answer < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :user
  belongs_to :question
  has_ancestry
  
  validates :body, presence: true

  def accept?
    self.accept == true
  end

  def set_accept
    transaction do
      question.answers.update_all(accept: false)
      update!(accept: true)
    end
  end
end