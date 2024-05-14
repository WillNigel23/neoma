module V2
  class ArticlesController < ApplicationController

    def index
      @articles = Article.live
    end

    def show
      @article = Article.friendly.find(params[:id])
      @suggested_articles = Article.live.where.not(id: @article.id).order('RANDOM()').limit(5)
    end

  end
end
