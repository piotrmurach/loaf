RSpec.describe Loaf::Crumb do
  it "fails when name is nil" do
    expect {
      Loaf::Crumb.new(nil, "path")
    }.to raise_error(ArgumentError,
                     /breadcrumb first argument, `name`, cannot be nil/)
  end

  it "fails when url is nil" do
    expect {
      Loaf::Crumb.new("name", nil)
    }.to raise_error(ArgumentError,
                    /breadcrumb second argument, `url`, cannot be nil/)
  end
end
