#layer cookbook
=============================


# Usage
1. Add a new custom layer:
  - Add `layer::{layer_name}` to the deploy lifecyle event recipes, before `play2::deploy` recipe

layer_name may be any of [web,api,background,all]
