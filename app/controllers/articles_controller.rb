class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:index, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def index
        @articles = Article.paginate(page: params[:page]).where(nil)
        @articles = Article.where("title ILIKE ?", "%#{params[:title]}%").paginate(page: params[:page]) if params[:title].present?
        @articles = Article.where("body ILIKE ?", "%#{params[:body]}%").paginate(page: params[:page]) if params[:body].present?
        @articles = Article.where("title ILIKE ?", "%#{params[:title]}%").where("body ILIKE ?", "%#{params[:body]}%").paginate(page: params[:page]) if params[:title].present? && params[:body].present?
    end

    def show
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        @article.user = current_user
        if @article.save
            flash[:notice] = "Article was succesfully created!!"
            redirect_to @article
        else   
            render :new
        end
    end

    def edit
    end

    def update
        if @article.update(article_params)
            flash[:notice] = "Article was updated succesfully"
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
        if @article.destroy
            flash[:notice] = "Article was Deleted succesfully"
            redirect_to articles_path
        end
    end

    private

        def article_params
            params.require(:article).permit(:title, :body, category_ids: [])
        end

        def set_article
            @article = Article.find(params[:id])
        end

        def require_same_user
            if current_user != @article.user && !current_user.admin?
                flash[:alert] = "You can only edit or delete your own article!!"
                redirect_to @article
            end
        end
end
