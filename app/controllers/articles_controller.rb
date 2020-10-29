class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]

    def index
        # Success *Static search
        # if params[:search]
        #     @articles = Article.where("title LIKE '%#{params[:search]}%'").or(Article.where("body LIKE '%#{params[:search]}%'"))
        # else
        #     @articles = Article.order('created_at ASC')
        # end
        # End Success

        # Success 2 * Static
        if params[:search]
            search = params[:search].downcase.gsub(/\s+/, "")
            @articles = Article.all.select{ |article|
                article.title.include?(search) ||
                article.body.include?(search) }
        else
            @articles = Article.all
        end
        # End Success
    end

    def show
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)

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
            params.require(:article).permit(:title, :body)
        end

        def set_article
            @article = Article.find(params[:id])
        end
end
