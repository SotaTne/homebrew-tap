class Typstlab < Formula
  desc "CLI tool for managing Typst writing projects"
  homepage "https://github.com/SotaTne/typstlab"
  url "https://github.com/SotaTne/typstlab/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "0009a758b4d1e19211ce8771c7ef8b7320daf9ea9b170b4e10c56ba2081f7d91"
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
