name "shu_stack"
description "A LAMP stack for Drupal with development tools, and relevant PHP libraries."
run_list(
  "role[damp_stack]",
  "recipe[composer]",
  "recipe[drush::composer]",
  "recipe[drushu]",
)
