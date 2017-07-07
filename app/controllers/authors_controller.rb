class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update, :destroy]
  
  # ===== RESTful actions =====
  
  #GET /authors
  def index
    @authors = Author.active.alphabetical.paginate(page: params[:page]).per_page(10)
  end
  
  #GET /authors/1
  def show
  end
  
  #GET /authors/1/edit
  def edit
  end
  
  #GET /authors/new
  def new
    @author = Author.new
  end
  
  #POST /authors
  def create
    @author = Author.new(author_params)
    if @author.save
      redirect_to author_path(@author), notice: "#{@author.name} was added to the system."
    else
      render action: 'new'
    end
  end

  #PATCH/PUT /authors/1
  def update
    if @author.update(author_params)
      redirect_to author_path(@author), notice: "#{@author.name} was revised in the system."
    else
      render action: 'edit'
    end
  end
  
  #DELETE /authors/1
  def destroy
    @author.destroy
    redirect_to authors_url
  end
  
  
  # ===== Private methods =====
  private
  
  def author_params
    params.require(:author).permit(:first_name, :last_name, :active)
  end
  
  def set_author
    @author = Author.find(params[:id])
  end
  
  
end
