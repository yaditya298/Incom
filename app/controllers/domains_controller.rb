class DomainsController < ApplicationController
  def new
    @domain = Domain.new
  end

  def create
    @domain = Domain.new(domain_params)
    if @domain.save
      flash[:notice] = I18n.t('domains.alerts.notice')
      redirect_to domains_path
    else
      flash[:alert] = I18n.t('shared.alert')
      render :new
    end
  end

  def index
    @domains = Domain.all.order(created_at: :desc)
  end

  def set
    status = false
    @domain = Domain.find(params[:id])
    if @domain
      Domain.transaction do
        status = Domain.update_all(current: nil) && @domain.update_attributes(current: true)
      end
    end
    render json: { status: status, domain: @domain.name }
  end

  private

  def domain_params
    params.require(:domain).permit(:name, :added_by_id)
  end
end
