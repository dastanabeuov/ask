class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy]

  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def edit; end

  def update
    @question.update(question_params) if current_user.author_of?(@question)
    redirect_to @question
    flash[:notice] = "Question updated!"
  end

  def destroy
    @question.destroy if current_user.author_of?(@question)
    flash[:notice] = "Question deleted!"
  end

  def create
    @question = current_user.questions.create(question_params)
    redirect_to @question
    flash[:notice] = "Question created!"
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
