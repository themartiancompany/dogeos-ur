# Maintainer: Pellegrino Prevete (dvorak) <pellegrinoprevete@gmail.com>
# Contributor: Fabio Castelli (muflone) <webreg@muflone.com>

_pkg="archiso"
_pkgbase="${_pkg}-profiles"
_pkg=dogeos
_profile="${_pkg}"
pkgname=(
  "${_profile}"
)
# _pkgver=$(date %s)
pkgver=v0.1+7+g3359a3e
pkgrel=2
pkgdesc='The DogeOS GNU/Linux base.'
url="https://www.humaninstrumentalityproject.org"
if [[ ! -v "_ns" ]]; then
  _ns="themartiancompany"
fi
_url="https://github/themartiancompany/${_pkg}"
arch=(
  any
)
depends=(
  'cryptsetup-sigfile'
  'dwm'
  'fakepkg'
  'mkinitcpio-archiso-encryption-git'
  'plymouth-nested-cryptkey'
  'polkit'
)
makedepends=(
  'devtools'
  'git'
)
checkdepends=(
  'shellcheck'
)
_commit="143be1cc01d0349782c8edbb9c0b2ff2bb1dcdcd" # 0.1
source=(
  "git+${_url}#commit=${_commit}"
)
sha256sums=(
  'SKIP'
)

pkgver() {
  cd \
    "${_pkg}" || \
    exit
  git \
    describe \
    --tags |
    sed \
      's/-/+/g'
}

package() {
  # shellcheck disable=SC2154
  local \
    _profile="${_pkgbase}/${_profile}"
  cd \
    "${_profile}" || \
    exit
  "./build_repo.sh" \
    fakepkg
  # pkexec mkarchiso -v "./" # ${_profile}"
}
