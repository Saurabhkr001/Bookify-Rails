class BooksController < ApplicationController
  before_action :set_book, only: [ :show, :edit, :update, :destroy, :buy, :purchased ]
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :authorize_user, only: [ :edit, :update, :destroy ]

  def index
    # if params[:filter] == "mine"
    #   @books = Book.where(user_id: current_user.id)
    # else
    #   @books = Book.all
    # end
    # @books =
    # case params[:filter]
    # when "my_books"
    #   user_signed_in? ? Book.Mine(current_user) : Book.all
    # else
    #   Book.all
    # end

    @books = Book.all 

    @books = @books.where(user_id: params[:user_id]) if params[:user_id].present?

    if params[:filter] == "my_books" && user_signed_in?
      @books = @books.merge(Book.Mine(current_user))
    end
  end

  def edit
  end

  def show
    @cover_image = @book.cover_image
  end

  def new
    @book = current_user.books.build
  end

  def create
    @book = current_user.books.build(book_params)
    @user = current_user

    if @book.save
      # BookMailer.book_published(@book, @user).deliver_now
      redirect_to @book, notice: "Book created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def buy
    if @book.increment!(:total_purchases)
      redirect_to books_path, notice: "Purchase successful!"
    else
      redirect_to book_path(@book), alert: "Error processing purchase."
    end
  end

  def purchased
    @total = @book.total_purchases
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: "Book was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: "Book deleted."
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:author, :description, :price, :cover_image, :book_file, :title, :genre)
  end

  def authorize_user
    unless @book.user == current_user
      redirect_to books_path, alert: "You can only modify your own books."
    end
  end
end
