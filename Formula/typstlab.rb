class Typstlab < Formula
  desc "Manage Typst writing projects"
  homepage "https://github.com/SotaTne/typstlab"
  url "https://github.com/SotaTne/typstlab/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "0009a758b4d1e19211ce8771c7ef8b7320daf9ea9b170b4e10c56ba2081f7d91"
  license "Apache-2.0"
  head "https://github.com/SotaTne/typstlab.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/SotaTne/homebrew-tap/releases/download/typstlab-0.1.2"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "b87440243b0909e2a9efab6dda42f7524930ce7559c6c634e6f86b2ea3d2864b"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "a2e81997a3f1d8028b277340a0b0f9651ee239eb78cb76d3e0b076c3621f8095"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c8aedc90abe725b101eefc601b70b82e83a24731b3e6d4e43ce95ef5945b11bc"
  end

  depends_on "pkgconf" => :build
  depends_on "rust" => :build

  on_linux do
    depends_on "openssl@3"
  end

  def install
    system "cargo", "install", "--locked", "--path", "crates/typstlab-cli", "--root", prefix
  end

  test do
    system bin/"typstlab", "new", "sample"
    assert_path_exists testpath/"sample/typstlab.toml"

    assert_match version.to_s, shell_output("#{bin}/typstlab --version")
  end
end
