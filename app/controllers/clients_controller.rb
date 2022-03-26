class ClientsController < ApplicationController

    #total clients in all the shops combined
    def total_clients
        render json: { results: Client.count }.to_json, status: :ok
    end
end
