class Cillers < Formula
  desc "The Cillers CLI"
  homepage "https://cillers.com"
  version "0.0.3"
  url "https://github.com/Cillers-com/cillers-cli/archive/refs/tags/v0.0.3.tar.gz"
  sha256 "f86a5458ed2a95498eddfe53ba5035e1341767b7903d95f6428ff04d129e6d63"

  # Git is needed to create a new Cillers system. 
  depends_on "git"

  # Polytope runs on Docker. 
  depends_on "docker"

  # Cillers runs on Polytope.
  dependa_on "polytope-cli"

  # Insomnia is our preferred API client UI, since it has great support for
  # GraphQL and oAuth. 
  depends_on "insomnia"

  # OrbStack is much more resource effective than Docker Desktop on macOS.
  # Cillers may not run well on Docker Desktop on macOS, unless you have a 
  # powerful laptop.
  on_macos do
    depends_on "orbstack"
  end

  def install
    # Install everything into libexec
    libexec.install Dir["*"]

    # Create a wrapper in the bin directory
    (bin/"cillers").write_env_script libexec/"cillers.rb", GEM_HOME: Formula["ruby"].opt_libexec/"gem"
  end

  def caveats
    <<~EOS
      This tool depends on polytope-cli, which is available through the polytopelabs tap.
      Please ensure you have tapped this repository before installing:
 
        brew tap polytopelabs/tap
    EOS
  end
  
  test do
    system "#{bin}/cillers", "help"
  end
end

