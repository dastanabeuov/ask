class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy]

  def index
    respond_with(@questions = Question.all)
  end

  def show
    @answer = Answer.new
    respond_with(@question)
  end

  def new
    respond_with(@question = Question.new)
  end

  def edit; end

  def update
    @question.update(question_params) if current_user.author_of?(@question)
  end

  def destroy
    respond_with(@question.destroy) if current_user.author_of?(@question)
  end

  def create
    @question = current_user.questions.create(question_params)
    respond_with @question
  end

  private

  def set_question
    @question ||= Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
