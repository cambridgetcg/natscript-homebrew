class Natscript < Formula
  desc "A programming language where natural language IS the syntax"
  homepage "https://natscript.vercel.app"
  url "https://github.com/cambridgetcg/natscript/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "1bd4036ccfdb0ade84bdf261a8f549288ca19be445e89290e1d69ab43b0655ec"
  license "MIT"

  depends_on "python@3.9"

  def install
    libexec.install "natscript.py"
    (bin/"natscript").write_env_script libexec/"natscript.py", PATH: "/usr/local/opt/python@3.9/bin:/usr/bin:/bin"
  end

  test do
    assert_match "hello world", shell_output("#{bin}/natscript -e 'say \"hello world\"'")
  end
end
