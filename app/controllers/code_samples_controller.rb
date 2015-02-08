class CodeSamplesController < ApplicationController
  def index
    @test_genre1 = Genre.find(1)
    @test_genre2 = Genre.find(2)
  end
end
