class SwitchController < ApplicationController
  def index
    @context ||= "Black"
  end

  def switch
    @context = params[:context]
  end

  def ajax_param
    params.require(:switch).permit(:context)
  end
end
