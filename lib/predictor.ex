defmodule Predictor do
  use GenServer

  def init(_) do
    {:ok, nil}
  end

  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def retrieve_model() do
    GenServer.call(:global.whereis_name(:learner), :retrieve_params)
  end

  def predict(params) do
    max = 100
    match_count =
      1..max
      |> Enum.count(fn n ->
        pred = NxFizzBuzz.predict_fizz_buzz(params, n)
        answer = NxFizzBuzz.fizz_buzz(n)
        matched = pred == answer
        IO.puts("#{n}: prediction: #{pred}, answer: #{answer}, matched?: #{matched}")
        matched
      end)

    IO.puts("================")
    IO.puts("Accuracy: #{match_count / max}")
  end
end
