defmodule Scheduler do

  
require Logger

  # TuneMe: The number of child signature generators to 
  # run as a multiple of the number of available cores.
  # I'm assuming initially that we need more processes than
  # processors as there'll be I/O blocking
  @over_commit 5

  # And the number of files processed at a time in each
  # individual child process
  @chunk_size  1

  @doc """
  We find the signatures of a list of file names. The file
  name list is potentially long (in the millions) so it is
  implemented lazily. We allocate a number of child processes
  to calculate the signatures. These are hungry consumers, asking
  us for work. We send each a chunk of _n_ file paths, and they return
  the corresponding signatures when they've been calculated.
  """
  def run(path_stream, batch) do
    Logger.info "Scheduler.run(...). I'm #{inspect self}"
    child_count = :erlang.system_info(:logical_processors) * @over_commit
    Enum.map(1..child_count, fn _ -> SignatureGenerator.start_link(self) end)
    loop(child_count, path_stream, batch)
  end


  # The wee trick here is that `next_n_files` returns `nil` when
  # there are no files left. When a signer recieves a `nil`
  # it shuts down.
  def loop(running_count, path_stream, batch) do
    receive do
      { :send_work, signer } ->
        Logger.info("send work #{inspect(signer)}")
        send(signer, { :process, self, next_n(path_stream), batch } )
        loop(running_count, path_stream, batch)

      { :processed, signer, signatures } ->
        Logger.info("processed #{inspect(signatures)}")
        send(signer, { :process, self, next_n(path_stream), batch } )
        loop(running_count, path_stream, batch)

      { :shutdown, signer } ->
        Logger.info("shutdown #{inspect(signer)}")
        if running_count > 1 do
           loop(running_count - 1, path_stream, batch)
        end
    end
  end

  def next_n(path_stream) do
    DirWalker.next(path_stream, @chunk_size)
  end
end
