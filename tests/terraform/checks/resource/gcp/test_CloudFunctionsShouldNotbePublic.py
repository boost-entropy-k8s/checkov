import unittest
from pathlib import Path

from checkov.runner_filter import RunnerFilter
from checkov.terraform.checks.resource.gcp.CloudFunctionsShouldNotBePublic import check
from checkov.terraform.runner import Runner


class TestCloudFunctionsShouldNotBePublic(unittest.TestCase):
    def test(self):
        # given
        test_files_dir = Path(__file__).parent / "example_CloudFunctionsShouldNotBePublic"

        # when
        report = Runner().run(root_folder=str(test_files_dir), runner_filter=RunnerFilter(checks=[check.id]))

        # then
        summary = report.get_summary()

        passing_resources = {
            "google_cloudfunctions_function_iam_member.pass",
            "google_cloudfunctions_function_iam_binding.pass",
            "google_cloudfunctions_function_iam_binding.pass2",
            "google_cloudfunctions2_function_iam_member.pass",
            "google_cloudfunctions2_function_iam_binding.pass",
            "google_cloudfunctions2_function_iam_binding.pass2",
        }

        failing_resources = {
            "google_cloudfunctions_function_iam_member.fail",
            "google_cloudfunctions_function_iam_binding.fail",
            "google_cloudfunctions_function_iam_binding.fail2",
            "google_cloudfunctions2_function_iam_member.fail",
            "google_cloudfunctions2_function_iam_binding.fail",
            "google_cloudfunctions2_function_iam_binding.fail2",
        }

        passed_check_resources = {c.resource for c in report.passed_checks}
        failed_check_resources = {c.resource for c in report.failed_checks}

        self.assertEqual(summary["passed"], 6)
        self.assertEqual(summary["failed"], 6)
        self.assertEqual(summary["skipped"], 0)
        self.assertEqual(summary["parsing_errors"], 0)

        self.assertEqual(passing_resources, passed_check_resources)
        self.assertEqual(failing_resources, failed_check_resources)


if __name__ == "__main__":
    unittest.main()
