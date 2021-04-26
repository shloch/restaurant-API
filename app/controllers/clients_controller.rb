class ClientsController < ApplicationController

    def total_clients
        render json: { results: Client.count }.to_json, status: :ok
    end
end
