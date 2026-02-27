class WhisperkitVkCli < Formula
  desc "On-device speech recognition for Apple Silicon, optimized by vibekernels"
  homepage "https://github.com/vibekernels/whisperkit-vk"
  url "https://github.com/vibekernels/whisperkit-vk/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "PLACEHOLDER"
  license "MIT"
  head "https://github.com/vibekernels/whisperkit-vk.git", branch: "main"

  bottle do
    root_url "https://github.com/vibekernels/whisperkit-vk/releases/download/v0.1.0"
    # Populated automatically by CI on release
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
