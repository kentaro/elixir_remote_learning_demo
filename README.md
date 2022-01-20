# Elixir Remote Learning Demo

Toward a distributed machine Learning infrastructure for IoT systems in Elixir, this repository demonstrates remote learning and predicting between two Elixir nodes.

## Usage

For details, see https://speakerdeck.com/kentaro/toward-a-distributed-machine-learning-infrastructure-for-iot-systems-in-elixir

### Setup

**Learner node**:

```
$ iex --sname learner -S mix run scripts/learner.ex

iex(learner@keyaki)1> {:ok, pid} = Learner.start_link()
{:ok, #PID<0.226.0>}
```


**Predictor node**:

```
$ iex --sname predictor -S mix run scripts/predictor.ex

iex(predictor@keyaki)1> Node.connect(:learner@keyaki)
true
iex(predictor@keyaki)2> Predictor.start_link()
{:ok, #PID<0.222.0>}
```

### Learning

In the predictor session:

```
$ iex(learner@keyaki)2> GenServer.cast(pid, :learn)
...
epoch 50, batch 197
epoch 50, batch 198
epoch 50, batch 199
```

### Predicting

```
iex(predictor@keyaki)3> params = Predictor.retrieve_params()
iex(predictor@keyaki)4> Predictor.predict(params)
1: prediction: 1, answer: 1, matched?: true
2: prediction: 2, answer: 2, matched?: true
3: prediction: Fizz, answer: Fizz, matched?: true
…
98: prediction: 98, answer: 98, matched?: true
99: prediction: Fizz, answer: Fizz, matched?: true
100: prediction: Buzz, answer: Buzz, matched?: true
================
Accuracy: 1.0
```
