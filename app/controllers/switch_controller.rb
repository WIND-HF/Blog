class SwitchController < ApplicationController
  respond_to :json
  def index
    @context ||= "Black"
  end

  def show
    #name = params[:name] || "None"
  end

  def music
    root = 'public'
    path = '/music'
    filelist = Dir.entries(File.join(root, path)).collect { |filename| File.join(root, path, filename) }
    filelist = filelist.select { |filename| File.file? filename }

    filelist.each do |filename|
      next if Music.find_by(:name=>(File.basename filename)) != nil

      m = Music.new
      m.name = File.basename(filename)
      m.filetype = File.extname(filename)[1..-1]
      m.path = File.join('/', path)

      m.save
    end

    @playlist = Music.all
  end

  def song
    song = Music.find(params[:id])
    songPath = File.join(song.path, song.name)

    respond_with path: songPath, type: song.filetype
  end

  def ajax_param
    params.require(:switch).permit(:context)
  end
end
