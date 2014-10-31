class LinesController < ApplicationController
  def index
    @lines = Line.all.order(:order_num)
  end

  def sort
    @lines = Line.all
    @lines = @lines.sort_by {|line| line.name.length }
    @lines = @lines.each_with_index {|line, index| line.order_num = index + 1 }
    save_all

    redirect_to lines_path
  end

  def new
    @line = Line.new
  end

  def show
    @line = Line.find params[:id]
  end

  def create
    @line = Line.new line_params

    if @line.save
      post = Publisher.instance.post @line
      post.each do |provider, res|
        s = Storage.new
        s.provider = Provider.find_by(type: provider.capitalize)
        if res['error']
          s.state = "error"
        else
          s.state = "success"
          s.post_id = provider == :vk ? res['response']['post_id'] : @line.img.file ? res['post_id'] : res['id']
        end
        @line.storages << s
      end
      @line.save
      redirect_to lines_path
    else
      render :new
    end
  end

  def sync
    @lines = Lines.all
    Publisher.instance.sync @lines
  end

  def edit
    @line = Line.find params[:id]
  end

  def update
    @line = Line.find params[:id]
    if @line.update line_params 
      redirect_to lines_path
    else
      render 'edit'
    end
  end

  def destroy
    @line = Line.find params[:id]
    Publisher.instance.delete @line
    @line.destroy

    redirect_to lines_path
  end

  private
    def line_params
      params.require(:line).permit(:name, :img)
    end 

    def save_all 
      @lines.each { |line| line.save! }
    end
end








