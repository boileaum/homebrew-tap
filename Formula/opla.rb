class Opla < Formula
  include Language::Python::Virtualenv

  desc "A personal webpage generator"
  homepage "https://gitlab.math.unistra.fr/irma/opla"
  url "https://gitlab.math.unistra.fr/irma/opla/-/archive/v1.1.3/opla-v1.1.3.tar.gz"
  version "v1.1.3"
  sha256 "8dac9680d9f9466d64bb468ccace61afe0048a6daf4e339233136a8dbf744613"
  license "MIT"

  depends_on "python@3.11"

  def install
    virtualenv_create(libexec, "python3.11", without_pip: false)
    system libexec/"bin/pip", "install", buildpath
    bin.install_symlink libexec/"bin/opla"
  end

  test do
    system "#{bin}/opla", "--help"

    (testpath/"test.md").write <<~EOS
      ---
      title: Test
      ---
      # Test

      Ceci est un test.
    EOS

    system "#{bin}/opla", "test.md", "-o", "build"
    assert_predicate testpath/"build/index.html", :exist?
  end
end
