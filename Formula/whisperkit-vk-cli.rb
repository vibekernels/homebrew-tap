class WhisperkitVkCli < Formula
  desc "On-device speech recognition for Apple Silicon, optimized by vibekernels"
  homepage "https://github.com/vibekernels/whisperkit-vk"
  url "https://github.com/vibekernels/whisperkit-vk/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "b27c4b7df492945010b01c10e671e12f48a4f5f179bb963064c7921205ccc0bf"
  license "MIT"
  head "https://github.com/vibekernels/whisperkit-vk.git", branch: "main"

  bottle do
    root_url "https://github.com/vibekernels/whisperkit-vk/releases/download/v0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "b45d2338e359c6e00d84f13776288ac9dac8cff264e2f0bac2c50e39bcf177d5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c163a52633b8ff99c22362a440449c28cf8956e5ad6fe718636d1a51ae32dee7"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "fcc54dc338ebca7dc9616cbd3b513d414623c36e0de5934fd8014494f6aa57ef"
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
