class WhisperkitVkCli < Formula
  desc "On-device speech recognition for Apple Silicon, optimized by vibekernels"
  homepage "https://github.com/vibekernels/whisperkit-vk"
  url "https://github.com/vibekernels/whisperkit-vk/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "ea4b16e36d36b4a02cdb3340fee1ff3cc911dec114c6dfb64a3850b9cc887ae5"
  license "MIT"
  head "https://github.com/vibekernels/whisperkit-vk.git", branch: "main"

  bottle do
    root_url "https://github.com/vibekernels/whisperkit-vk/releases/download/v0.1.1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "b0522c3a73600f39f449c28cd99958819bd27c2892d5e227ec02a3c32451138e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7ecea65b89d28b85824251be4fed5bb121a3de1a802a2b0212e407e1f64929e7"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "075414f9aa89aa4b69cf59ab096597dc6e73093fc4bd32c97fc523e9e16c17e9"
  end

  depends_on xcode: ["15.0", :build]
  depends_on :macos

  def install
    system "swift", "build", "-c", "release", "--product", "whisperkit-cli"
    bin.install ".build/release/whisperkit-cli" => "whisperkit-vk-cli"
  end

  test do
    system bin/"whisperkit-vk-cli", "--help"
  end
end
