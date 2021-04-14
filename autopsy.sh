cd /
if [[ -z "${DISPLAY}" ]]; then
  echo "DISPLAY environment variable not passed. This is required to get a GUI."
  echo "."
  echo "Show readme to help you out:"
  cat /tools/README.md | tr -s '#' ' ' | tr -s '`' ' '
else
  /tools/autopsy-4.18.0/bin/autopsy
fi
