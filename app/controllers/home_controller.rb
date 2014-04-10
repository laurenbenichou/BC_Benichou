class HomeController < ApplicationController
respond_to :json

  def index
  end

  def rates
    # Call to external API with Typhoeus.
    cad_request = Typhoeus.get("https://api.bitcoinaverage.com/ticker/global/CAD/last")
    eur_request = Typhoeus.get("https://api.bitcoinaverage.com/ticker/global/EUR/last")
    @cad_response =  cad_request.body
    @eur_response =  eur_request.body

    # Generates time and formats time to HH:MM:SS
    time = Time.now
    time = time.strftime("%H:%M:%S")

    # Render json object
    render json: { :cad => @cad_response, :eur => @eur_response, :time => time}
  end

end
