class Admin::WorksController < AdminController
  
  before_filter :load_work, :only => [ :show, :edit, :update, :destroy ]
  
  def index
    @works = Work.order('last_name, first_name, title')
  end
  
  def new
    @work = Work.new
  end

  def edit
  end
  
  def create
    @work = Work.new(params[:work])
    if @work.save
      redirect_to [:admin, @work], notice: 'Work saved'
    else
      render action: "new"
    end
  end
  
  def update
    if @work.update_attributes(params[:work])
      redirect_to [:admin, @work], notice: 'Work was successfully updated.'
    else
      render action: "edit"
    end
  end
  
  def destroy
    @work.destroy
    redirect_to admin_works_path, notice: 'Work deleted'
  end
  
end
