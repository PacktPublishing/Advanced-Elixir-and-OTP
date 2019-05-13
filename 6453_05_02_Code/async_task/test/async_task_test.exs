defmodule TaskTest do
  use AsyncTask

  @async false
  task do_sync() do
    :hello
  end

  @async true
  task do_async(caller) do
    send(caller, :hello)
  end

  @async false
  @timeout 1_000
  @timeout_response :late_to_the_party
  task do_sync_timely(waiting_time) do
    :timer.sleep(waiting_time)
    :hello
  end
end

defmodule AsyncTaskTest do
  use ExUnit.Case
  doctest AsyncTask

  test "simple sync call" do
    assert TaskTest.do_sync() == :hello
  end

  test "simple async call" do
    pid = TaskTest.do_async(self())
    assert is_pid(pid)
    assert_receive :hello
  end

  test "timeout response" do
    assert TaskTest.do_sync_timely(200) == :hello
    assert TaskTest.do_sync_timely(2_000) == :late_to_the_party
  end
end
