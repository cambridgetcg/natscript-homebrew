class Natscript < Formula
  desc "A programming language where natural language IS the syntax"
  homepage "https://natscript.vercel.app"
  url "https://github.com/cambridgetcg/natscript/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "bd227e21e86482ca1def39b114b393ce8024cf3d5a8387c84b2c5e261f99f2a4"
  license "MIT"

  depends_on "python@3.9"

  def install
    bin.install "natscript.py" => "natscript"
  end

  test do
    assert_match "hello world", shell_output("#{bin}/natscript -e 'say \"hello world\"'")
  end
end
