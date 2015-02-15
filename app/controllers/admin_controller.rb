class AdminController < ApplicationController
  before_action :authenticate!

  def index
  end

  def admin?
    true
  end

  def csv
    send_data(Work.to_csv, type: 'text/csv',
                           filename: 'momenta.csv', disposition: 'attachment')
  end
end
