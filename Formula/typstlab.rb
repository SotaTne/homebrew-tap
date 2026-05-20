class Typstlab < Formula
  desc "CLI tool for managing Typst writing projects"
  homepage "https://github.com/SotaTne/typstlab"
  url "https://github.com/SotaTne/typstlab/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "eb4d132c474d1fc12c71d4e73581e6f1faaa25eaa13a6a808d1d7eefbfac8af9"
  license "Apache-2.0"
  head "https://github.com/SotaTne/typstlab.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
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
