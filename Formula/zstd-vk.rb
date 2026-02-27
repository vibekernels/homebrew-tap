class ZstdVk < Formula
  desc "ARM64-optimized Zstandard compression for Apple Silicon"
  homepage "https://github.com/vibekernels/zstd-vk"
  url "https://github.com/vibekernels/zstd-vk/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "7eb5419f4aad9208fb30ee22cfe1f89d9e474a0230c878811eaecfc564ceddb9"
  license "BSD-2-Clause"
  head "https://github.com/vibekernels/zstd-vk.git", branch: "main"

  bottle do
    root_url "https://github.com/vibekernels/zstd-vk/releases/download/v0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8c953338ebf8784743d7b8510abcabc31969ef088ca433e3b630483d317530c8"
  end

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
