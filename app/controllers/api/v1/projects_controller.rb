module Api::V1

  class ProjectsController < ApplicationController

    before_action :set_project, only: [:show]
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    # GET /projects
    def index
      @projects = Project.all

      render json: @projects
    end

    # GET /projects/1
    def show
      render json: @project
    end

    private

    # Search for project, defaulting to key if id not found
    def set_project
      @project = Project.find_by(id: params[:id]) || Project.find_by(key: params[:id])
      if @project.nil?
        raise ActiveRecord::RecordNotFound
      end
    end

    # Only allow a trusted parameter "white list" through.
    def project_params
      params.require(:project).permit(:name, :description, :github_link, :start_date, :finish_date, :status)
    end

    # Handle record not found exceptions
    def record_not_found
      render json: {error: 404}
    end

  end

end

