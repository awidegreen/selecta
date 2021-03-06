require_relative "spec_helper"

describe Renderer do
  let(:config) { Configuration.from_inputs(["one", "two", "three"],
                                           Configuration.default_options,
                                           3) }

  it "renders selected matches" do
    search = Search.blank(config).down
    renderer = Renderer.new(search)
    expect(renderer.render.choices).to eq [
      "> ",
      "one",
      Text[:inverse, "two", :reset],
    ]
  end

  it "renders with no matches" do
    search = Search.blank(config).append_search_string("z")
    renderer = Renderer.new(search)
    expect(renderer.render.choices).to eq [
      "> z",
      "",
      "",
    ]
  end

  it "respects the visible choice limit" do
    config = Configuration.from_inputs(["one", "two", "three"],
                                       Configuration.default_options,
                                       2)
    search = Search.blank(config)
    renderer = Renderer.new(search)
    expect(renderer.render.choices).to eq [
      "> ",
      Text[:inverse, "one", :reset],
    ]
  end
end
