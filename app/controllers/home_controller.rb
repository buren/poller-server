class HomeController < ApplicationController
  def index
    render 'pages/index'
  end

  # GET /clear
  # Clear database
  def clear
    status = 200
    question = params[:question]
    record = params[:record]

    if question.blank?
      status = 422
      message = "question can't be blank"
    else
      if record == 'point'
        Point.where(question: question).delete_all
        message = 'Points deleted.'
      elsif record == 'poll'
        Answer.where(question: question).delete_all
        message = 'Answer deleted.'
      else
        status = 422
        message = "record can't be blank and must be either 'point' or 'poll'."
      end
    end

    render json: { status: status, message: message }
  end
end
