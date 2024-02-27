require 'securerandom'
require 'uri'

class UrlsController < ApplicationController

  def redirect
    @url = Url.find_by(url_short: params[:url_short])

    if @url
      @url.increment!(:count_visits)
      redirect_to @url.url_complete, allow_other_host: true
    else
      render plain: "404 Not Found, The Url Shortened, Not Exist.", status: :not_found
    end

  end

  def show
    urls = Url.all
    render json: urls
  end

  def new
    @url = Url.new
    @url_short = params[:url_short] if params[:url_short].present?
  end

  def create
    url_complete = url_params[:url_complete]

    unless validate_url(url_complete)
      flash[:alert] = "Invalid URL"
      return redirect_to new_url_path
    end

    @url = Url.new(url_params)
    @url.url_short = generate_short_url

    if @url.save
      redirect_to root_url(url_short: @url.url_short)
    else
      flash[:alert] = "The shortened URL already exists"
      redirect_to new_url_path
    end

  end

  private

  def url_params
    params.require(:url).permit(:url_complete, :url_short, :count_visits)
  end

  def generate_short_url
    SecureRandom.alphanumeric(5)
  end

  def validate_url(url)
    url = URI.parse(url)
    url.is_a?(URI::HTTP) || url.is_a?(URI::HTTPS)
  end

end
