data "archive_file" "set_visit_count_file" {
  output_path = "set_visit_count.zip"
  type        = "zip"
  source_file = "set_visit_count.py"
}

data "archive_file" "get_visit_count_file" {
  output_path = "get_visit_count.zip"
  type        = "zip"
  source_file = "get_visit_count.py"
}