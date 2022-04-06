class Host::ListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_listing, only: %i[show edit update destroy]

  def index
    @listings = current_user.listings.order(:id)
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = current_user.listings.new(listing_create_params)

    if @listing.save
      redirect_to host_listings_path(@listing)
    else
      flash.now[:errors] = @listing.errors.full_messages
      render :new
    end
  end

  def edit; end

  def update
    if @listing.update(listing_update_params)
      redirect_to host_listings_path(@listing)
    else
      flash.now[:errors] = @listing.errors.full_messages
      render :edit
    end
  end

  def show; end

  def destroy
    @listing.update(status: :archived)

    redirect_to host_listings_path
  end

  private

  def find_listing
    @listing = current_user.listings.find_by(id: params[:id])
  end

  def listing_create_params
    params.require(:listing).permit(
      :title,
      :about,
      :max_guests,
      :address_line1,
      :address_line2,
      :city,
      :state,
      :postal_code,
      :country
    )
  end

  def listing_update_params
    params.require(:listing).permit(
      :title,
      :about,
      :max_guests
    )
  end
end
