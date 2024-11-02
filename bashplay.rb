class Bashplay < Formula
  desc "Description of your bash script"
  homepage "https://github.com/CoolCoder54323/homebrew-bashMusic"
  url "https://github.com/CoolCoder54323/homebrew-bashMusic/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "40a71e2640f7811e4334744bc61e4a90ba12207c1bc42b504b75a746ca747e54"
  license "MIT" # Or your script's license

  def install
    bin.install "bashPlay.sh" => "bashplay"
  end

  test do
      assert_predicate bin/"bashplay", :exist? # Simple check if executable exists
  end
end
