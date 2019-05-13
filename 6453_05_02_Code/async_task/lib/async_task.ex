defmodule AsyncTask do
  defmacro __using__(_opts) do
    quote do
      import AsyncTask

      @async false
      @timeout 10_000
      @timeout_response nil
    end
  end

  defmacro task(header, do: body) do
    quote do
      def unquote(header) do
        case @async do
          true -> spawn(fn -> unquote(body) end)
          _ ->
            caller = self()
            spawn(fn -> send(caller, unquote(body)) end)

            receive do
              message -> message
            after
              @timeout -> @timeout_response
            end
        end
      end
    end
  end
end
