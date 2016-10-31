# -*- encoding : utf-8 -*-
class AlaveteliProfessionalController < ApplicationController

  def login
    render :login, :layout => 'pro'
  end

  def frontpage
    render :frontpage, :layout => false
  end

  def find_auth
    render :find_auth, :layout => 'pro'
  end

  def find_auth_2
    render :find_auth_2, :layout => 'pro'
  end

  def find_auth_2_v2
    render :find_auth_2_version_2, :layout => 'pro'
  end

  def write_request
    render :write_request, :layout => 'pro'
  end

  def write_request_v2
    render :write_request_version_2, :layout => 'pro'
  end

  def preview_request
    @info_request = params[:info_request]
    @body = PublicBody.visible.find(params[:info_request][:public_body_id])
    @info_request[:public_body] = @body
    @outgoing_message = params[:outgoing_message]
    @set_embargo = params[:set_embargo] == "1"
    if @set_embargo
      @set_embargo = true
      @embargo = params[:embargo]
      @set_embargo_default = params[:set_embargo_default] == "1"
    end
    render :preview_request, :layout => 'pro'
  end

  def dashboard
    render :dashboard, :layout => 'pro'
  end

  def requests
    render :requests, :layout => 'pro'
  end

  def request_in_progress
    render :request_in_progress, :layout => 'pro'
  end

  def request_awaiting_response
    if params[:show_new_request_flash]
      flash.now[:notice] = "We’ve sent your request to the Department for Exiting the European Union"
    end
    if params[:info_request]
      # Assuming that if there's an info request param we're coming from the
      # preview page and so we should use the details from that request
      @info_request = params[:info_request]
      @body = PublicBody.visible.find(params[:info_request][:public_body_id])
      @info_request[:public_body] = @body
      @outgoing_message = params[:outgoing_message]
      @set_embargo = params[:set_embargo] == "1"
      if @set_embargo
        @set_embargo = true
        @embargo = params[:embargo]
        @set_embargo_default = params[:set_embargo_default] == "1"
      end
      flash.now[:notice] = "We’ve sent your request to the #{@body.name}"
    end
    render :request_awaiting_response, :layout => 'pro'
  end

  def marketing
    render :marketing, :layout => 'pro'
  end

  def bodies_json
    if params[:query]
      xapian_result = perform_search_typeahead(params[:query], PublicBody)
      if xapian_result.nil?
        results = []
      else
        results = xapian_result.results
      end
    else
      results = []
    end
    results = results.map do |result|
      body_as_search_result(result[:model]).merge({score: result[:percent]})
    end
    render json: results
  end

  private

  def body_as_search_result(body)
    {
      id: body.id,
      name: body.name,
      notes: ActionController::Base.helpers.truncate(ActionController::Base.helpers.strip_tags(body.notes), length: 150),
      info_requests_visible_count: body.info_requests_visible_count
    }
  end

end