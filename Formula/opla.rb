class Opla < Formula
  include Language::Python::Virtualenv

  desc "A personal webpage generator"
  homepage "https://gitlab.math.unistra.fr/irma/opla"
  url "https://gitlab.math.unistra.fr/irma/opla/-/archive/v1.1.5/opla-v1.1.5.tar.gz"
  version "v1.1.5"
  sha256 "a4c6b51f6c54818b41081ff9aff021f9af8c3dc33e5c78858a97a44b840d4ec8"
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
