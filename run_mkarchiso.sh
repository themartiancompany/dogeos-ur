#!/usr/bin/env bash

# SPDX-License-Identifier: AGPL-3.0

#    -----------------------------------------------------
#    Copyright © 2024, 2025, 2026  Pellegrino Prevete
#
#    All rights reserved
#    -----------------------------------------------------
#
#    This program is free software: you can redistribute
#    it and/or modify it under the terms of the
#    GNU Affero General Public License as published by
#    the Free Software Foundation, either version 3 of
#    the License, or (at your option) any later version.
#
#    This program is distributed in the hope that it
#    will be useful, but WITHOUT ANY WARRANTY;
#    without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#    See the GNU Affero General Public License for
#    more details.
#
#    You should have received a copy of the
#    GNU Affero General Public License
#    along with this program.
#    If not, see <https://www.gnu.org/licenses/>.

# Because pkexec can't export 
_run_mkarchiso() {
  local \
    _pacman_conf="${1}" \
    _gnupg_homedir="${2}" \
    _dest="${3}" \
    _pgp_key_id="${4}" \
    _pgp_sender="${5}" \
    _work_dir="${6}" \
    _profile="${7}" \
    _quiet="${8}" \
    _archiso_opts=() \
    _quiet_args=()
  _archiso_opts=(
    -C "${_pacman_conf}"
    -o "${_dest}"
    -g "${_pgp_key_id}"
    -G "${_pgp_sender}"
    -H "${_gnupg_homedir}"
    -w "${_work_dir}"
  )
  if [[ "${_quiet}" != "y" ]]; then
    _quiet_args=(
      '-v'
    )
  fi
  export \
    GNUPGHOME="${_gnupg_homedir}"
  chown \
    -R  \
      "0:0" \
    "${_gnupg_homedir}"
  env \
    GNUPGHOME="${_gnupg_homedir}" \
  mkarchiso \
    "${_archiso_opts[@]}" \
    "${_quiet_args[@]}" \
    "${_profile}"
}

gnupg_homedir="${1}"
dest="${2}"
pgp_key_id="${3}"
pgp_sender="${4}"
work_dir="${5}"
profile="${6}"
quiet="${7}"
app_opts=(
  "${gnupg_homedir}"
  "${dest}"
  "${pgp_key_id}"
  "${pgp_sender}"
  "${work_dir}"
  "${profile}"
  "${quiet}"
)
GNUPGHOME="${gnupg_homedir}" \
_run_mkarchiso \
  "${app_opts[@]}"
