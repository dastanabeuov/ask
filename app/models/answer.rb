class Answer < ApplicationRecord
  default_scope { order(created_at: :asc) }

  belongs_to :user
  belongs_to :question

  validates :body, presence: true

  def accept?
    self.best == true
  end

  def set_accept
    transaction do
      question.answers.update_all(accept: false)
      update!(accept: true)
    end
  end
end