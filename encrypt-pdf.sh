#!/bin/bash
# This script uses qpdf to encrypt a file.
#
# usage: encrypt-pdf.sh file-to-encrypt.pdf output-name.pdf

echo "enter password: "
read -rs pw

qpdf --encrypt "$pw" "$pw" 256 -- "$1" "$2"
