class BatchesController < ApplicationController
  def new
    @user = current_user
    @batch = Batch.new
  end
  def create
    @owner = current_user
    @batch = Batch.new
  end
end
