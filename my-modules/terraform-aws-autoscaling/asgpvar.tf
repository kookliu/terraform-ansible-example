variable "autoscaling_policies_enabled" {
  type        = "string"
  default     = "true"
  description = "Whether to create `aws_autoscaling_policy` and `aws_cloudwatch_metric_alarm` resources to control Auto Scaling"
}

variable "scale_up_policy_name" {
  type        = "string"
  default     = "myASG-Up-Policy"
}

variable "scale_down_policy_name" {
  type        = "string"
  default     = "myASG-down-Policy"
}

variable "scale_up_cooldown_seconds" {
  type        = "string"
  default     = "300"
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start"
}

variable "scale_up_scaling_adjustment" {
  default     = 1
  description = "The number of instances by which to scale. `scale_up_adjustment_type` determines the interpretation of this number (e.g. as an absolute number or as a percentage of the existing Auto Scaling group size). A positive increment adds to the current capacity and a negative value removes from the current capacity"
}

variable "scale_up_adjustment_type" {
  type        = "string"
  default     = "ChangeInCapacity"
  description = "Specifies whether the adjustment is an absolute number or a percentage of the current capacity. Valid values are `ChangeInCapacity`, `ExactCapacity` and `PercentChangeInCapacity`"
}

variable "scale_up_policy_type" {
  type        = "string"
  default     = "SimpleScaling"
  description = "The scalling policy type, either `SimpleScaling`, `StepScaling` or `TargetTrackingScaling`"
}

variable "scale_down_cooldown_seconds" {
  type        = "string"
  default     = "300"
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start"
}

variable "scale_down_scaling_adjustment" {
  default     = -1
  description = "The number of instances by which to scale. `scale_down_scaling_adjustment` determines the interpretation of this number (e.g. as an absolute number or as a percentage of the existing Auto Scaling group size). A positive increment adds to the current capacity and a negative value removes from the current capacity"
}

variable "scale_down_adjustment_type" {
  type        = "string"
  default     = "ChangeInCapacity"
  description = "Specifies whether the adjustment is an absolute number or a percentage of the current capacity. Valid values are `ChangeInCapacity`, `ExactCapacity` and `PercentChangeInCapacity`"
}

variable "scale_down_policy_type" {
  type        = "string"
  default     = "SimpleScaling"
  description = "The scalling policy type, either `SimpleScaling`, `StepScaling` or `TargetTrackingScaling`"
}

variable "cloudwatch_metric_alarm_cpu_high_name" {
  type        = "string"
  default     = "myASG-Up-Alarm-CPU-High"
}

variable "cloudwatch_metric_alarm_cpu_low_name" {
  type        = "string"
  default     = "myASG-Up-Alarm-CPU-Low"
}


variable "cpu_utilization_high_evaluation_periods" {
  type        = "string"
  default     = "1"
  description = "The number of periods over which data is compared to the specified threshold"
}

variable "cpu_utilization_high_period_seconds" {
  type        = "string"
  default     = "60"
  description = "The period in seconds over which the specified statistic is applied"
}

variable "cpu_utilization_high_threshold_percent" {
  type        = "string"
  default     = "80"
  description = "The value against which the specified statistic is compared"
}

variable "cpu_utilization_high_statistic" {
  type        = "string"
  default     = "Average"
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: `SampleCount`, `Average`, `Sum`, `Minimum`, `Maximum`"
}

variable "cpu_utilization_low_evaluation_periods" {
  type        = "string"
  default     = "1"
  description = "The number of periods over which data is compared to the specified threshold"
}

variable "cpu_utilization_low_period_seconds" {
  type        = "string"
  default     = "60"
  description = "The period in seconds over which the specified statistic is applied"
}

variable "cpu_utilization_low_threshold_percent" {
  type        = "string"
  default     = "10"
  description = "The value against which the specified statistic is compared"
}

variable "cpu_utilization_low_statistic" {
  type        = "string"
  default     = "Average"
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: `SampleCount`, `Average`, `Sum`, `Minimum`, `Maximum`"
}

