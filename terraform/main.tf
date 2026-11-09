data "aws_organizations_organization" "current" {}
resource "aws_organizations_organizational_unit" "security" {
  name = "Security"
  parent_id = data.aws_organizations_organization.current.roots[0].id
}
resource "aws_organizations_organizational_unit" "workloads" {
  name = "Workloads"
  parent_id = data.aws_organizations_organization.current.roots[0].id
}
resource "aws_organizations_organizational_unit" "sandbox" {
  name = "Sandbox"
  parent_id = data.aws_organizations_organization.current.roots[0].id
}
resource "aws_organizations_policy" "deny_leave_org" {
  count = var.enable_example_scp ? 1 : 0
  name = "DenyLeaveOrganization"
  description = "Example guardrail preventing member accounts from leaving the organization."
  type = "SERVICE_CONTROL_POLICY"
  content = file("${path.module}/policies/deny-leave-organization.json")
}
resource "aws_organizations_policy_attachment" "sandbox_guardrail" {
  count = var.enable_example_scp ? 1 : 0
  policy_id = aws_organizations_policy.deny_leave_org[0].id
  target_id = aws_organizations_organizational_unit.sandbox.id
}
output "organization_id" { value = data.aws_organizations_organization.current.id }
output "ou_ids" {
  value = {
    security = aws_organizations_organizational_unit.security.id
    workloads = aws_organizations_organizational_unit.workloads.id
    sandbox = aws_organizations_organizational_unit.sandbox.id
  }
}
