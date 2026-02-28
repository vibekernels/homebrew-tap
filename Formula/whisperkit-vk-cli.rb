class WhisperkitVkCli < Formula
  desc "On-device speech recognition for Apple Silicon, optimized by vibekernels"
  homepage "https://github.com/vibekernels/whisperkit-vk"
  url "https://github.com/vibekernels/whisperkit-vk/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "1579c399020da11a2e898dc44b1bc9f61d95aacff100bb9a8770e035b09dccb2"
  license "MIT"
  head "https://github.com/vibekernels/whisperkit-vk.git", branch: "main"

  bottle do
    root_url "https://github.com/vibekernels/whisperkit-vk/releases/download/v0.2.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "d51f3fe5c3bdcb008fcd1996c6202503798aeae656f68f877fc6b6e812cf41c0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "70016fe163c17632f650b2a9c9c3a16f7f038d6fa0e7b8bc29b0990132458c50"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "a3405972c9c79925f52f4226c26786e0e803d8056cab827774e7510b5ce88e6a"
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
