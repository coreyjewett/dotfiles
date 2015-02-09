# Use like any of these (and other similar variations):
#
#  $> jenkins_get /tmp/screenshot_2015-01-29-20-10-57.808.png
#  $> jenkins_get /tmp/screenshot_2015-01-29-20-10-57
#  $> jenkins_get screenshot_2015-01-29-20-10-57.808
#  $> jenkins_get screenshot_2015-01-28-23
#
# will fetch the PNG/HTML (or several of each if the <fname> globs them),
# open the PNG(s), and show URIs for the HTML. If your <fname> is bad it'll tell you.
jenkins_get() {
  fname=$(echo $1 | sed -Ee 's|^/tmp/||; s/.(png|html)$//;');
  scp jenkins.connect.fluke.com:/tmp/$fname\* /tmp;
  if [ $? -ne 0 ]; then
    echo Invalid asset name: $fname 1>&2 1>/dev/null;
  else
    for x in /tmp/$fname*.html; do echo file://$x; done
    open /tmp/$fname*.png;
  fi
}
