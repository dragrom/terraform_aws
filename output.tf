output "repository_url" {
    value = "${module.aws_ecr.url_repository}"
}

output "build_log_group_name" {
    value = "${module.aws_cloud_watch.cloud_watch_group_name}"
}


