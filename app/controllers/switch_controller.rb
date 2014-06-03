class SwitchController < ApplicationController
  respond_to :json
  def index
    @context ||= "Black"
  end

  def new
  end

  def show
    #name = params[:name] || "None"
  end

  def music
    update_playlist('/music')

    @playlist = Music.all
  end

  def song
    @song = Music.find(params[:id])
    @songPath = File.join(@song.path, @song.name)

    respond_with path: @songPath, type: @song.filetype
  end

  def upload
    @song = params[:music][:song]
    @path = 'music'
    @root = 'public'

    File.open(File.join(@root, @path, @song.original_filename), 'wb') do |file|
      file.write(@song.read)
    end
    add_song(@song.original_filename, @song.content_type, @path)

    redirect_to switch_music_path
  end

  def ajaxUpload
    @song = params[:song]
    @path = 'music'
    @root = 'public'

    File.open(File.join(@root, @path, @song.original_filename), 'wb') do |file|
      file.write(@song.read)
    end
    add_song(@song.original_filename, @song.content_type, @path)

    redirect_to switch_music_path
  end

  private
  def upload_param
    params.require(:song).permit(:music)
  end

  def add_song(filename, type, path='/music')
      if Music.find_by(:name=>(File.basename filename)) == nil
        m = Music.new
        m.name = File.basename(filename)
        m.filetype = music_format(type)
        m.path = File.join('/', path)

        m.save
      end
  end

  def update_playlist(path)
    @root = 'public'
    @path = File.join('/', path)
    @filelist = Dir.entries(File.join(@root, @path)).collect { |filename| File.join(@root, @path, filename) }
    @filelist = @filelist.select { |filename| File.file? filename }

    @filelist.each do |filename|
      add_song(filename, File.extname(filename)[1..-1])
    end
  end

  def music_format(fileType)
    unless /^(audio|video)\// === fileType
      if /(wav|mp3|ogg|aac)/ === fileType
        fileType = 'mpeg' if fileType == 'mp3'
        return 'audio/' + fileType
      elsif /(mp4|mkv)/ === fileType
        return 'video/' + fileType
      else
        return fileType
      end
    end

    fileType
  end
end
