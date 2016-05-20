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

  option "without-qt5", "Build against Qt4 instead of Qt5 (default)"

  if build.with? "qt5"
    depends_on "poppler" => "with-qt5"
  end

  if build.without? "qt5"
    depends_on "poppler" => "with-qt"
  end

  def install
    args = std_cmake_args
    args << "-DUsePrerenderedPDF=ON"
    args << "-DRunDualScreenTests=OFF"
    if build.with? "qt5"
      args << "-DUseQtFive=ON"
    else
      args << "-DUseQtFive=OFF"
    end

    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      system "ctest", "--output-on-failure", "--timeout", "60"
      system "make", "install"
    end
  end

  test do
    assert_match /#{version}/, shell_output("#{bin}/dspdfviewer --version", 1)
  end
end
