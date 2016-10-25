# -*- encoding : utf-8 -*-
class AlaveteliProfessionalController < ApplicationController

  def login
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
    render :preview_request, :layout => 'pro'
  end

  def dashboard
    render :dashboard, :layout => 'pro'
  end

  def marketing
    render :marketing, :layout => 'pro'
  end

  def bodies_json
    # TODO params[:query] is the search query
    bodies = []
    PublicBody.visible.each do |body|
      bodies.append({
        id: body.id,
        name: body.name,
        description: body.notes,
        requests: body.info_requests_count
      })
    end
    render json: bodies
  end

end