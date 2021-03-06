class Bank::Manage::Teaching::TestPapersController < Bank::Manage::ApplicationController
  def index
    @test_papers = QuestionBank::TestPaper.page params[:page]
  end

  def show
    @test_paper = QuestionBank::TestPaper.find params[:id]
  end

  def new
    @test_paper = QuestionBank::TestPaper.new
  end

  def create
    @test_paper = QuestionBank::TestPaper.new test_paper_params
    return redirect_to [:bank, :manage, :test_papers] if @test_paper.save
    render :action => :new
  end

  def edit
    @test_paper = QuestionBank::TestPaper.find(params[:id])
  end


  def update
    @test_paper = QuestionBank::TestPaper.find(params[:id])
    return redirect_to [:bank, :manage, @test_paper] if @test_paper.update_attributes test_paper_params
    render :action => :new
  end

  def destroy
    @test_paper = QuestionBank::TestPaper.find(params[:id])
    @test_paper.destroy
    redirect_to [:bank, :manage, @test_paper]
  end

  def preview
    tmp_params = test_paper_params
    tmp_params.delete(:id)
    tmp_params[:sections_attributes].each_value{|v| v.delete(:id)} if tmp_params[:sections_attributes]
    @test_paper = QuestionBank::TestPaper.new tmp_params
    render :show
  end

  def enable
    @test_paper = QuestionBank::TestPaper.find(params[:id])
    @test_paper.update_attribute :enabled, true
    redirect_to [:bank, :manage, :test_papers]
  end

  def disable
    @test_paper = QuestionBank::TestPaper.find(params[:id])
    @test_paper.update_attribute :enabled, false
    redirect_to [:bank, :manage, :test_papers]
  end

  protected
  def test_paper_params
    params.require(:test_paper).permit(:title, :score, :minutes, :sections_attributes => [:kind, :score, :min_level, :max_level, :position, :id, :_destroy, :question_ids_str])
  end
end

