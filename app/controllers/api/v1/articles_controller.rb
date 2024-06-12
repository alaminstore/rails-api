class Api::V1::ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    articles = Article.all 
    render json: articles, status: 200
  end

  def show
    article = Article.find_by(id: params[:id])
    if article
      render json: article, status: 200
    else
      render json: {
        success: false,
        code: 404,
        message: "Article not found!",
      }
    end
  end

  def create
    article = Article.new(
      title: arti_params[:title],
      body: arti_params[:body],
      author: arti_params[:author]
    )
    if article.save
      render json: article, status: 201
    else
      render json: {
        success: false,
        code: 404,
        error: "Error creationg new articles"
      }
    end
  end

  def update
    article = Article.find_by(id: params[:id])
    if article
      article.update(title: params[:title], body: params[:body], author: params[:author])
      render json: {
         success: true, 
         code: 204,
         message: "Article updated successfully",
        data: article
      }
    else
      render json: {
        success: false,
        code: 404,
        message: "Plese provide valid article"
      }
    end
  end

  def destroy
    article = Article.find_by(id: params[:id])
    if article
      article.destroy
      render json: {
        success: true,
        code: 204
        message:
      }
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
