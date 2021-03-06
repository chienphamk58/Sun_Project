class TvShowsController < ApplicationController
  before_action :load_tvshow, only: :show
  before_action :build_movie_tvshow, only: %i(index show)

  def index
    @tv_shows = TvShow.create_desc.page(params[:page]).per Settings.paginate
  end

  def show; end

  private

  def load_tvshow
    @tv_show = TvShow.find_by id: params[:id]

    if @tv_show
      @critic_score = @tv_show.score(:critic)
      @audience_score = @tv_show.score(:normal)
      @celebrities = TvShow.celebrities_list @tv_show.id
    else
      flash[:danger] = t ".not_found"
      redirect_to tv_shows_url
    end
  end


  def build_movie_tvshow
    @top_score_movie = Movie.create_top_score
    @top_score_movie_tab = @top_score_movie.take Settings.tab_show

    @top_score_tvshow = TvShow.all.create_top_score
    @top_score_tvshow_tab = @top_score_tvshow.take Settings.tab_show
  end
end
