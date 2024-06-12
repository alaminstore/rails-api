class Api::V1::ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: {
      message: 'hello'
    }
  end

  def show
  end

  def create
    article = Article.new(
      title: arti_params[:title],
      body: arti_params[:body],
      author: arti_params[:author]
    )
    if article.save
      render json: article, status: 200
    else
      render json: {
        error: "Error creationg new articles"
      }
    end
  end

  def update
  end

  def destroy
  end

  private
  def arti_params
    params.require(:article).permit([
      :title,
      :body,
      :author
    ])
  end
end
