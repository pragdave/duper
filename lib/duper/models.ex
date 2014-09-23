defmodule Batch do
  use Ecto.Model

  schema "batches" do
    field :base_folder, :string
    has_many :signatures, Signature
  end

  def exists_for_folder?(folder, repo) do
    length(for_folder(folder, repo)) > 0
  end

  def for_folder(folder, repo) do
    q =  from  w in Batch,
        where: w.base_folder == ^folder,
       select: w.id
    repo.all(q)
  end

  def run(folder, repo) do
    b = repo.insert(%Batch{base_folder: folder})
    {:ok, walker} = DirWalker.start_link(folder)
    Scheduler.run(walker, b)
  end

  def rerun(batch, repo) do
    folder = batch.base_folder
    repo.delete(batch)
    run(folder, repo)
  end

  def signature_count(batch, repo) do
    from(batch.signatures, select: count(1)) |> repo.one
  end

  def normalize(path) do
    Path.expand(path, ".")
  end
end

defmodule Signature do
  use Ecto.Model

  schema "signatures", primary_key: {:path, :string, []} do
    field :signature, :binary
    belongs_to :batch, Batches
  end

  def for_signature(signature, repo) do
    scoped(s, where: s.signature == binary(^signature)) |> repo.all
  end
end

defmodule Dup do
  use Ecto.Model

  schema "dups", primary_key: {:signature, :binary, []} do
  end

  def count(repo) do
    from(Dup, select: count(1)) |> repo.one
  end

  def first_ten(repo) do
    scoped(d, limit: 10, order_by: d.signature) |> repo.all
  end

  def first_ten_signatures(repo) do
    first_ten(repo)
    |> Enum.map(&(Signature.for_signature(&1.signature, repo)))
  end
end
