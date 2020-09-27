class ArticlesController < ApplicationController
    def index
        @articles = Article.order("created_at ASC")
    end

    def show
        @article = Article.find(params[:id])
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)

        if @article.save
            flash[:notice] = "Article was succesfully created!!"
            redirect_to articles_path
        else   
            render :new
        end
    end

    def edit
       @article = Article.find(params[:id]) 
    end

    def update
        @article = Article.find(params[:id])
        if @article.update(article_params)
            flash[:notice] = "Article was updated succesfully"
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
        @article = Article.find(params[:id])
        if @article.destroy
            flash[:notice] = "Article was Deleted succesfully"
            redirect_to articles_path
        end
    end

    private
        def article_params
            params.require(:article).permit(:title, :body)
        end
end
