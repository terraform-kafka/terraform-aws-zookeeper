/*
Copyright 2018 Bryan Frimin.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

variable "count" {
  description = "Size of the Zookeeper cluster."
  default     = 3
}

variable "subnet_ids" {
  type        = "list"
  description = "List of subnet ids. (the order should be the same of subnet_cidr var."
}

variable "subnet_cidr" {
  type        = "list"
  description = "List of subnet cidr."
}

variable "ami" {
  type        = "string"
  description = "The AMI to use for the instance."
}

variable "ebs_optimized" {
  description = "EC2 detailed monitoring."
  default     = true
}

variable "disable_api_termination" {
  description = ""
  default     = true
}

variable "monitoring" {
  description = ""
  default     = true
}

variable "tags" {
  type        = "map"
  description = "Extra tags to add on the created subnets."
  default     = {}
}

variable "name" {
  type        = "string"
  description = ""
}

variable "instance_type" {
  type = "string"
  description = ""
}

variable "user_data_base64" {
  type = "string",
  description =  ""
}

