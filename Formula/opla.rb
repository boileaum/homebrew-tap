class Opla < Formula
  include Language::Python::Virtualenv

  desc "A personal webpage generator"
  homepage "https://gitlab.math.unistra.fr/irma/opla"
  url "https://gitlab.math.unistra.fr/irma/opla/-/archive/v1.1.0/opla-v1.1.0.tar.gz"
  sha256 "f412a0f1f2af19e9a448f74e4b711a3b1b49e289749cff64aa8a23cdcfe8c654"
  license "MIT"

  depends_on "python@3.11"

  def install
    # Create virtual environment with pip
    virtualenv_create(libexec, "python3.11", without_pip: false)
    
    # Install the package directly (let pip handle dependencies)
    system libexec/"bin/pip", "install", "--upgrade", "pip"
    system libexec/"bin/pip", "install", buildpath
    
    # Create symlink to the executable
    bin.install_symlink libexec/"bin/opla"
  end

  test do
    system "#{bin}/opla", "--help"
  end
end