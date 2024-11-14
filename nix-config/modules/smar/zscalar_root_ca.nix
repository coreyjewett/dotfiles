{ pkgs, ... }:

{
  # Fetch the private root cert from the system keychain
  security.pki.certificateFiles = [
    (pkgs.runCommand "zscaler-root-ca.pem" { } ''
      ${pkgs.bash}/bin/bash -c "/usr/bin/security find-certificate -a -p -c \"Zscaler Root CA\" > $out"
    '')
  ];
}
