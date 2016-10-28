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

  def requests
    render :requests, :layout => 'pro'
  end

  def request_in_progress
    render :request_in_progress, :layout => 'pro'
  end

  def marketing
    render :marketing, :layout => 'pro'
  end

  def bodies_json
    bodies = [
      {
        id: 3,
        name: "Attorney General’s Office",
        description: "",
        requests: 231
      },
      {
        id: 4,
        name: "Cabinet Office",
        description: "The Cabinet Office is a department of the Government of the United Kingdom responsible for supporting the Prime Minister and Cabinet.",
        requests: 1321
      },
      {
        id: 5,
        name: "Department for Business, Energy and Industrial Strategy",
        description: "Also called BEIS. The department brings together responsibilities for business, industrial strategy, science, innovation, energy, and climate change.",
        requests: 34
      },
      {
        id: 6,
        name: "Department for Business, Innovation and Skills",
        description: "Also called BIS. As of July 2016 department's responsibilities have been taken on by Department for Business, Energy and Industrial Strategy.",
        requests: 685
      },
      {
        id: 7,
        name: "Department for Environment, Food and Rural Affairs",
        description: "Also called Defra. ",
        requests: 846
      },
      {
        id: 8,
        name: "Department for Exiting the European Union",
        description: "Also called DEEU. The Government department responsible for overseeing negotiations to leave the EU and establishing the future relationship between the UK and EU. ",
        requests: 15
      },
      {
        id: 2,
        name: "Department for Transport",
        description: "The Department for Transport (Welsh: Adran am Drafnidiaeth) is the government department responsible for the English transport network and a limited number of transport matters in Scotland, Wales and Northern Ireland which are not devolved. DfT is run by the Secretary of State for Transport. The work of DfT used to be carried out by the Ministry of Transport, this name lives on in 'MOT' test.",
        requests: 1368
      }
      ]
    render json: bodies
  end

end