defmodule SignatureGenerator do

  require Logger

  def start_link(scheduler) do
    spawn_link(__MODULE__, :kickoff, [scheduler])
  end

  def kickoff(scheduler) do
    Logger.info "Kickoff #{inspect(self)}, scheduler is #{inspect scheduler}"
    send(scheduler, {:send_work, self})
    loop(scheduler)
  end

  def loop(scheduler) do
    receive do
      { :process, ^scheduler, nil, _batch } ->
        Logger.info("Shutting down #{inspect self}")
        send(scheduler, { :shutdown, self })

      { :process, ^scheduler, filelist, batch } ->
        Logger.info("Process #{inspect self}")
        result = process_files(filelist, batch)
        send(scheduler, { :processed, self,  result})
        loop(scheduler)
    end
  end

  def process_files(filelist, batch) do
    for path <- filelist, do: process_file(path, batch)
  end

  def process_file(path, batch) do
    case File.open(path) do

      {:error, reason } ->
        Logger.error "Failed to open #{path}: #{reason}"
        { :error, path, reason }

      { :ok, device } ->
        stream    = IO.binstream(device, 128*1024)
        context   = :crypto.hash_init(:md5)
        signature = Enum.reduce(stream, context, &(:crypto.hash_update(&2, &1)))
        File.close(device)
        hash = :crypto.hash_final(signature)
        Store.add_signature(path, hash, batch)
        { :ok, path, hash}
    end
  end
end
