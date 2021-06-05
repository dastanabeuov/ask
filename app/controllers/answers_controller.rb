class AnswersController < ApplicationController
  before_action :set_question, only: %i[create]
  before_action :set_answer, only: %i[update destroy set_accept]

  def create
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    @answer.save
    respond_with(@answer)
  end

  def update
    @answer.update(answer_params) if current_user.author_of?(@answer)
    respond_with(@answer)
  end

  def destroy
    @answer.destroy if current_user.author_of?(@answer)
    redirect_to @answer.question
    flash[:success] = "Answer deleted!"
  end

  def set_accept
    @answer.set_accept if current_user.answer.children.include?(@answer)
  end

  private

  def set_question
    @question ||= Question.find(params[:question_id])
  end

  def set_answer
    @answer ||= Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end