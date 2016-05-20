class Dspdfviewer < Formula
  desc "Dual-Screen PDF Viewer for latex-beamer"
  homepage "http://dspdfviewer.danny-edel.de"
  url "https://github.com/dannyedel/dspdfviewer/archive/v1.15.tar.gz"
  sha256 "19986053ac4a60e086a9edd78281f1e422a64efef29e3c6604386419e9420686"
  revision 1
  head "https://github.com/dannyedel/dspdfviewer.git"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "boost"
  depends_on "poppler" => "with-qt5"

  def install
	extra_args = %W[
	  -DUseQtFive=ON
	  -DUsePrerenderedPDF=ON
	  -DRunDualScreenTests=OFF
	]

	mkdir "build" do
      system "cmake", "..", *(std_cmake_args + extra_args)
      system "make", "install"
    end
  end

  test do
    assert_match /#{version}/, shell_output("#{bin}/dspdfviewer --version", 1)
  end
end
