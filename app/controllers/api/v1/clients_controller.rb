class Api::V1::ClientsController < ApplicationController
	before_action :set_client, except: [:index, :create]

	# Renders a list of client as json.
	# api/v1/clients
	def index
		@clients = Client.all
		render json: @clients, status: :ok
	end

	# Renders a client as json.
	# api/v1/clients/:slug
	def show
		render json: @client, status: :ok
	end

	# Creates a new client with a json payload.
	# api/v1/clients/{:client}
	def create
		@client = Client.new(client_params)
		if @client.save
			render json: @client, status: :ok
		else
			render json: { message: "Invalid Client.",
				errors: @client.errors }, status: :not_acceptable
		end
	end

	# Updates an existing client with a json payload.
	# api/v1/clients/:slug/{:client}
	def update
		if @client.update(client_params)
			render json: @client, status: :ok
		else
			render json: { message: "Invalid Client.",
				errors: @client.errors }, status: :not_acceptable
		end
	end

	# Destroys an existing client
	# api/v1/clients/:slug method :delete
	def destroy
		@client.destroy
		render json: { message: "Client deleted." }, status: :ok
	end

	private 
		def set_client
			@client = Client.find_by(slug: params[:id])
		end

		def client_params
			params.permit(:name, :address, :phone, :slug, :website)
		end

end
