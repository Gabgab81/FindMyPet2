class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @adverts = Advert.order('created_at desc').limit(8)
    @markers = @adverts.geocoded.map do |advert|
      {
          lat: advert.latitude,
          lng: advert.longitude,
          info_window: render_to_string(partial: "shared/info_window", locals: {advert: advert})
          # image_url: helpers.asset_url("/cartoon-dogs1.png")
      }
    end
    # raise
  end
end
