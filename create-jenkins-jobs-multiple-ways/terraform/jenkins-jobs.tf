resource "jenkins_job" "multibranch-jobs" {
  count  = length(var.multibranch-jobs)
  name   = element(var.multibranch-jobs, count.index)
  folder = "/job/multibranch-jobs"
  template = templatefile("${path.module}/multibranch-job.xml", {
    git_repo = element(var.multibranch-jobs, count.index)
  })
}

resource "jenkins_job" "pipeline-jobs" {
  count  = length(var.pipeline-jobs)
  name   = element(var.pipeline-jobs, count.index)
  folder = "/job/pipeline-jobs"
  template = templatefile("${path.module}/pipeline-job.xml", {
    git_repo = element(var.pipeline-jobs, count.index)
  })
}



