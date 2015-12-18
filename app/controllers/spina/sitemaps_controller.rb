module Spina
  class SitemapsController < BaseController
    def show
      @pages = Page.live.sorted
    end
  end
end
