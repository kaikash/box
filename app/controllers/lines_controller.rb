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

  # def reorder
  #   # params => {'id' => 13, 'after_id' => 43, 'before_id' => 64}

  #   @line = Line.find params[:id]
  #   @after = Line.find params[:after_id]
  #   @before = Line.find params[:before_id]
  #   sort if @bofore.order_num - @after.order_num < 0
  #   @line.order_num = (@bofore.order_num + @after.order_num) / 2
  #   @line.save
  # end

  def new
    @line = Line.new
  end

  def show
    @line = Line.find params[:id]
  end

  def create
    @line = Line.new line_params

    if @line.save
      post = Publisher.instance.post(@line)
      post.each do |provider, res|
        s = Storage.new
        s.provider = Provider.find_by(name: provider)
        if res['error']
          s.state = "error"
        else
          s.state = "success"
          s.post_id = provider == :vk ? res['response']['post_id'] : @line.img.file ? res['response']['post_id'] : res['response']['id']
        end
        @line.storages << s
      end
      @line.save
    
    # if @line.save
    #   post = Publisher.instance.post(@line)
    #   post.each do |provider, res|
    #     if res['error']
    #       s = Storage.new({state: "error"})
    #       s.provider = Provider.find((provider == :vk) ? 1 : 2)
    #     else
    #       s = Storage.new({state: "success"})
    #       case provider
    #       when :vk
    #         s.provider = Provider.find 1
    #         s.params_obj = {post_id: res['response']['post_id']}
    #       when :fb
    #         s.provider = Provider.find 2
    #         s.params_obj = {post_id: (@line.img.file) ? res['response']['post_id'] : res['response']['id']}
    #       end
    #     end
    #     @line.storages << s
    #   end
    #   @line.save

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
    Publisher.instance.delete(@line)
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








