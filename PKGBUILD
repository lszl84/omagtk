# Maintainer: Lukasz Sromek <https://github.com/lszl84>

# Builds from this checkout: run makepkg -si in the repository root.

pkgname=omagtk
pkgver=0.1.0
pkgrel=1
pkgdesc="A modern GTK3 theme that follows your Omarchy theme"
arch=(any)
url="https://github.com/lszl84/omagtk"
license=(MIT)
depends=(bash gawk glib2 gtk3)
install=omagtk.install

package() {
  cd "$startdir"

  install -Dm755 bin/omagtk "$pkgdir/usr/bin/omagtk"
  install -Dm644 theme/index.theme "$pkgdir/usr/share/omagtk/theme/index.theme"
  install -Dm644 -t "$pkgdir/usr/share/omagtk/theme/gtk-3.0" theme/gtk-3.0/gtk.css theme/gtk-3.0/gtk-dark.css
  install -Dm755 hooks/omagtk "$pkgdir/usr/share/omagtk/hooks/omagtk"
  install -Dm644 README.md "$pkgdir/usr/share/doc/omagtk/README.md"
  install -Dm644 LICENSE "$pkgdir/usr/share/licenses/omagtk/LICENSE"
}
