include:
  - init.yum-repo

base-pkg:
  pkg.installed:
    - pkgs:
      - screen
      - lrzsz
