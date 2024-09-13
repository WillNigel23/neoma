module V2
  module Admin
    class ArticlesController < BaseController

      def index
        @articles = Article.all.includes(:featured_item)
      end

      def new
        @article = Article.new
      end

      def edit
        @article = Article.find(params[:id])
      end

      def create
        @article = Article.new(article_params)

        if @article.save
          nested_content_sections_update_callback(:article)

          flash[:notice] = "Created #{@article.title} successfully"
          redirect_to edit_v2_admin_article_path(@article.id)
        else
          flash[:notice] = "Failed to create due to #{@article.errors.full_messages}"
          render :new
        end
      end

      def update
        @article = Article.find(params[:id])

        if @article.update(article_params)
          nested_content_sections_update_callback(:article)

          flash[:notice] = "Updated #{@article.title} successfully"
          redirect_to edit_v2_admin_article_path(@article.id)
        else
          flash[:notice] = "Failed to update due to #{@article.errors.full_messages}"
          render :edit
        end
      end

      def destroy
        article = Article.find(params[:id]).destroy

        flash[:notice] = "Deleted '#{article.title}' successfully"
        redirect_to v2_admin_articles_path
      end

      private

      def article_params
        params.require(:article).permit(
          :title,
          :subtitle,
          :description,
          :status,
          :date,
          :banner_id,
          content_sections_attributes: [
            :id,
            :header,
            :content,
            :position,
            :_destroy
          ]
        )
      end

    end
  end
end
