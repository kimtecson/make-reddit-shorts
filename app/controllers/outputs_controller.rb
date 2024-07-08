class OutputsController < ApplicationController
    def new
      @user = current_user
      @ouput = Output.new
    end
    def create
      @owner = current_user
      @ouput = Output.new
    end
    # def show
    # @user = current_user
    # # @sources = Source.all
    # @ouput = Output.find(params[:id])
    # end
end
