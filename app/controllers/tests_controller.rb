# frozen_string_literal: true
class TestsController < ApplicationController
  load_and_authorize_resource :assignment
  load_and_authorize_resource through: :assignment

  def page_title
    'Tests'
  end

  def new
    cast_test
  end

  def edit
  end

  def update
    if @test.update_attributes(test_params)
      redirect_to [@assignment.course, @assignment], flash: {success: 'Test was successfully updated'}
    else
      render 'new'
    end
  end

  def create
    cast_test
    if @test.save
      redirect_to [@assignment.course, @assignment], flash: {success: 'Test was successfully created'}
    else
      render 'new'
    end
  end

  def destroy
    @test.destroy
    redirect_to [@assignment.course, @assignment], flash: {success: 'Test was successfully deleted'}
  end

  private

  def cast_test
    @test = @test.becomes(ExpectedOutputTest)
    @test.type = ExpectedOutputTest
  end

  def test_params
    params[:test] ||= params[:expected_output_test]
    params.require(:test).permit(:name, :public, :description,
                                 :program_input, :expected_program_output)
  end
end
