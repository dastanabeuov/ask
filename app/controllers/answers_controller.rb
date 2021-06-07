class AnswersController < ApplicationController
  before_action :set_question, only: %i[create]
  before_action :set_answer, only: %i[show update destroy set_accept]

  def create
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    @answer.save
    redirect_to @answer.question
    flash[:notice] = "Answer created!"
  end

  def update
    @answer.update(answer_params) if current_user.author_of?(@answer)
    redirect_to @answer.question
    flash[:notice] = "Answer updated!"
  end

  def destroy
    @answer.destroy if current_user.author_of?(@answer)
    redirect_to @answer.question
    flash[:notice] = "Answer deleted!"
  end

  def set_accept
    @answer.set_accept
    root = @answer.root
    first, second = root.body, @answer.body
    root.update(body: first + ' ' + second)
    
    redirect_to @answer.question
    flash[:notice] = "Answer accepted!"
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, :parent_id)
  end
end