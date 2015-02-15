class WorksController < ApplicationController
  before_filter :accepted_guidelines?, only: :new
  before_filter :load_work, only: [:show, :edit, :update, :confirm]
  before_filter :authenticate_edit!, only: :edit
  http_basic_authenticate_with name: Rails.configuration.artist_auth_name,
                               password: Rails.configuration.artist_auth_pass,
                               only: [:new, :edit, :update, :confirm]
  before_filter :set_caching, only: [:index, :show]

  def index
    page = params[:page] || 1
    @works = Work.order('last_name, first_name, title').page(page).per(15)
  end

  def show
    # do prev/next links
    works = Work.order('last_name, first_name, title').select(:id)
    idx = works.index(@work)
    @previous_work = Work.find(works[idx - 1].id) if idx > 0
    @next_work = Work.find(works[idx + 1].id) if idx < works.length - 1
  end

  def new
    @work = Work.new
  end

  def edit
  end

  # rubocop:disable LineLength

  def preview
    if session[:preview_id]
      @work = Work.find(session[:preview_id])
    else
      @work = Work.new(params[:work])
    end
    if session[:preview_id] ? @work.update_attributes(params[:work]) : @work.save
      session[:preview_id] = @work.id
    else
      render action: (session[:preview_id] ? "edit" : "new")
    end
  end

  def create
    @work = Work.new(params[:work])
    if @work.save
      redirect_to @work, notice: 'Work saved'
    else
      render action: "new"
    end
  end

  def confirm
    if @work.id == session[:preview_id]
      @work.confirmed = true
      @work.save!
      session.delete(:preview_id)
      redirect_to '/thank_you'
    else
      redirect_to root_path,
                  notice: "An error occurred. Maybe your browser doesn't have cookies enabled?"
    end
  end

  def update
    if @work.update_attributes(params[:work])
      redirect_to @work, notice: 'Work was successfully updated.'
    else
      render action: "edit"
    end
  end

  private

  # make sure they accepted the guidelines before allowing a submission
  def accepted_guidelines?
    redirect_to(guidelines_path,
                notice: 'You must accept the submissions guidelines first!') unless session[:accept]
  end

  # for an edit, we need the preview_id in the session
  def authenticate_edit!
    redirect_to(login_path,
                notice: 'You must be logged in to visit that page') unless @work.id == session[:preview_id]
  end
end
