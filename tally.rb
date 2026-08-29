# Tally — Homebrew formula (tap: blakep-lms/homebrew-tools, formula: tally)
#   brew tap blakep-lms/homebrew-tools && brew install tally
# Installs the Tally CLI + scripts and symlinks `tally` onto PATH.
class Tally < Formula
  desc "Local-first passive time tracking: watch windows, bucket time, export for invoicing"
  homepage "https://github.com/blakep-lms/Tally"
  url "https://github.com/blakep-lms/Tally/releases/download/v0.1.0/tally-v0.1.0-fixed.tar.gz"
  sha256 "eb5f8492370384e08025ac3f879c125bc791418b22a5ebd1eacab2d308b11e72"
  license "MIT"

  depends_on "python@3.12"

  def install
    scripts = %w[
      tally.py watch.py store.py tally_setup.py tally_ctl.py tally_menu_v2.py
      tally_dashboard.py tally_export.py timeline.py suggest_rules.py doctor.py
      bucket_server.py bucket-editor.html
    ]
    # The release tarball nests everything under blakep-lms-Tally-<sha>/scripts/.
    Dir.chdir("scripts") do
      libexec.install scripts
    end
    bin.install libexec/"tally.py" => "tally"
  end

  def post_install
    ohai "Tally installed. Run `tally setup` to create your buckets."
  end

  test do
    assert_match "tally", shell_output("#{bin}/tally --help", 0)
  end
end
