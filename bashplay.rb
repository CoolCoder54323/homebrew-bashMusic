class Bashplay < Formula
  desc "Description of your bash script"
  homepage "https://github.com/CoolCoder54323/homebrew-bashMusic"
  url "https://github.com/CoolCoder54323/homebrew-bashMusic/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "bfc1f87be78db23a1a05e8dc6cffbb9b524c8ab2f6b6c5c25c5f47fe85e23345"
  license "MIT" # Or your script's license

  def install
    bin.install "bashPlay.sh" => "bashplay"
  end

  test do
      assert_predicate bin/"bashplay", :exist? # Simple check if executable exists
  end
end
