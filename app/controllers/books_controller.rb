class BooksController < ApplicationController
   before_action :authenticate_user!


def index
	@book = Book.new
	@books = Book.all
	@users = User.all
end

def show
	@book = Book.find(params[:id])
	@book_new = Book.new
	@user = @book.user
end

def create
	@book = Book.new(book_params)
	@book.user_id = current_user.id
 if @book.save
	redirect_to book_path(@book.id), notice: 'Book was successfully created.'
 else
 	@books = Book.all
		render :index
end
end

def edit
	@book = Book.find(params[:id])
	@user = @book.user
	if current_user != @user
		redirect_to books_path
	end
end

def update
	@book = Book.find(params[:id])
	if @book.update(book_params)
		redirect_to book_path(@book), notice: 'Book was successfully updated.'
	else
		render :edit
	end
end

def destroy
	@book = Book.find(params[:id])
	@book.destroy
	redirect_to books_path, notice: 'Book was successfully destroyed.'
end

private

def correct_user
     book = Book.find(params[:id])
     if current_user != book.user
       redirect_to books_path(current_user)
     end
end

def book_params
	params.require(:book).permit(:title, :body)
end
end