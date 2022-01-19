defmodule Learner do
  use GenServer
  require Logger

  def init(_) do
    :global.register_name(:learner, self())

    params = {
      Nx.random_uniform({20, 64}, 0.0, 1.0, names: [:input, :hidden]),
      Nx.random_uniform({64}, 0.0, 1.0, names: [:hidden]),
      Nx.random_uniform({64, 4}, 0.0, 1.0, names: [:hidden, :output]),
      Nx.random_uniform({4}, 0.0, 1.0, names: [:output])
    }

    {:ok, params}
  end

  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def handle_cast(:learn, _) do
    {features, labels} = NxFizzBuzz.Dataset.generate_dataset(10000, 20)
    params = NxFizzBuzz.Model.fit(features, labels, epoch: 50, batch_size: 50, hidden_size: 8)

    {:noreply, params}
  end

  def handle_call(:retrieve_params, _from, params) do
    {:reply, params, params}
  end
end
