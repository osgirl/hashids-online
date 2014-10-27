require 'pry'
require 'sinatra/base'
require 'sinatra/reloader'
require './exhibits/page_exhibit'

module HashidsOnline
  PageItem = Struct.new(:name, :title, :url, :template)

  class App < Sinatra::Base

    # If you want to set password protection for a particular environment,
    # uncomment this and set the username/password:
    #if ENV['RACK_ENV'] == 'staging'
      #use Rack::Auth::Basic, "Please sign in" do |username, password|
        #[username, password] == ['theusername', 'thepassword']
      #end
    #end


    def page_items
      @page_items ||= {
        home: PageExhibit.new(PageItem.new('home', 'Encoder', '/', :index), self),
        help: PageExhibit.new(PageItem.new('help', 'FAQs', '/help/', :help), self)
      }
    end

    configure :development do
      register Sinatra::Reloader
    end

    configure do
      # Set your Google Analytics ID here if you have one:
      # set :google_analytics_id, 'UA-12345678-1'
 
      set :layouts_dir, 'views/_layouts'
      set :partials_dir, 'views/_partials'

      set :server, %w[puma]
    end

    helpers do
      def show_404
        status 404
        @page_item = PageItem.new('404', '404', '')
        erb :'404', :layout => :with_sidebar,
                    :layout_options => {:views => settings.layouts_dir}
      end
    end

    not_found do
      show_404
    end

    # Redirect any URLs without a trailing slash to the version with.
    get %r{(/.*[^\/])$} do
      redirect "#{params[:captures].first}/"
    end

    get '/' do
      @page_item = page_items[:home]
      @page_item.render_page
    end

    # Routes for pages that have unique things...

    get '/help/' do
      @page_item = page_items[:help]
      @page_item.render_page
    end
  end
end
