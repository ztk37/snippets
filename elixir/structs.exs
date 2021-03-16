defmodule Note do
  alias Note

  @type title :: String.t()
  @type body :: String.t()
  @type tags :: [String.t()]

  @type t :: %__MODULE__{
          title: title,
          body: body,
          tags: tags
        }

  defstruct id: nil,
            title: "",
            body: "",
            tags: [],
            created_at: nil,
            updated_at: nil

  def test, do: IO.inspect(__MODULE__)

  @spec empty() :: t
  def empty, do: %Note{}

  @spec set_title(t, String.t()) :: t
  def set_title(note, title) do
    %{note | title: title}
  end

  @spec set_body(t, String.t()) :: t
  def set_body(note, body) do
    %{note | body: body}
  end

  @spec put_tag(t, String.t()) :: t
  def put_tag(%Note{tags: tags} = note, tag) do
    %{note | tags: [tag | tags]}
  end

  @spec put_tags(t, [String.t()]) :: t
  def put_tags(%Note{tags: tags} = note, new_tags) do
    %{note | tags: tags ++ new_tags}
  end

  @spec put_tags(t) :: [String.t()]
  def get_tags(%Note{tags: tags} = note), do tags
end

Note.empty()
|> Note.set_title("Damn! - Note heading")
|> Note.put_tag("a")
|> Note.put_tag("b")
|> Note.put_tag("c")
|> IO.inspect()
