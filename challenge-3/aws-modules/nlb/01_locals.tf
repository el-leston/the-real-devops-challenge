locals {
  tg_attachments = flatten([
    for instance_id in var.instances_ids : [
      for tg_key, tg_value in var.target_groups : {
        instance_id      = instance_id
        target_group_arn = aws_lb_target_group.this[tg_key].arn
        port             = lookup(tg_value, "port", 80)
        key              = "${instance_id}_${tg_key}"
      }
    ]
  ])
}
