output "url_repository" {
    value = "${aws_ecr_repository.docker.repository_url}"
} 