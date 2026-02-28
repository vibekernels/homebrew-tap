class ZstdVk < Formula
  desc "ARM64-optimized Zstandard compression for Apple Silicon"
  homepage "https://github.com/vibekernels/zstd-vk"
  url "https://github.com/vibekernels/zstd-vk/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "d09a6a4c103dc51fd414b5981ff212c2ccb109f263babfa64dd02756c647b8fa"
  license "BSD-2-Clause"
  head "https://github.com/vibekernels/zstd-vk.git", branch: "main"

  bottle do
    root_url "https://github.com/vibekernels/zstd-vk/releases/download/v0.2.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1e3ead12c5848e311393839a6d24de5f5e46a6d27c8d519e0aaaced39b601ed6"
  end

  depends_on "llvm" => :build

  def install
    llvm = Formula["llvm"]
    system "make", "-C", "programs", "zstd-release",
 "CC=#{llvm.opt_bin}/clang",
 "PREFIX=#{prefix}"

    bin.install "programs/zstd" => "zstd-vk"
    man1.install "programs/zstd.1" => "zstd-vk.1"
  end

  test do
    (testpath/"input.txt").write("Hello, World!" * 100)
    system bin/"zstd-vk", "input.txt"
    assert_path_exists testpath/"input.txt.zst"
    system bin/"zstd-vk", "-d", "input.txt.zst", "-o", "output.txt"
    assert_equal (testpath/"input.txt").read, (testpath/"output.txt").read
  end
end
