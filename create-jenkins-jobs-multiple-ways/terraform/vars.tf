variable "multibranch-jobs" {
  default = [
    "cart",
    "catalogue",
    "user",
    "frontend",
    "payment",
    "shipping"
  ]
}

variable "pipeline-jobs" {
  default = [
    "cart",
    "catalogue",
    "user",
    "frontend",
    "payment",
    "shipping"
  ]
}
