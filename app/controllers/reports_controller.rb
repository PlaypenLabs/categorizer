class ReportsController < ApplicationController

  def index
    @reports = Report.all
  end

  def new
    @r = Report.new
  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

end
