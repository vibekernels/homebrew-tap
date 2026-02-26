class ZstdVk < Formula
  desc "ARM64-optimized Zstandard compression for Apple Silicon"
  homepage "https://github.com/vibekernels/zstd-vk-macos-arm64"
  url "https://github.com/vibekernels/zstd-vk-macos-arm64/archive/refs/tags/v1.6.0.tar.gz"
  sha256 "PLACEHOLDER_SHA256"
  license "BSD-2-Clause"
  head "https://github.com/vibekernels/zstd-vk-macos-arm64.git", branch: "main"

  # Bottles are built by the zstd-vk-macos-arm64 CI and uploaded to its GitHub releases.
  # Update this block after each release using the bottle block from CI output.
  # bottle do
  #   root_url "https://github.com/vibekernels/zstd-vk-macos-arm64/releases/download/v1.6.0"
  #   sha256 cellar: :any_skip_relocation, arm64_sonoma: "PLACEHOLDER"
  # end

  depends_on "llvm" => :build

  def install
    llvm = Formula["llvm"]
    system "make", "-C", "programs", "zstd-release",
           "CC=#{llvm.opt_bin}/clang",
           "MOREFLAGS=-mcpu=apple-m1",
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
