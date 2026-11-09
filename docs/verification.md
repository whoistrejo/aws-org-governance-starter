# Verification

This lab requires an existing AWS Organization with all features enabled and credentials authorized to manage OUs and SCPs. The management account is the usual place to manage SCPs.

Start with `enable_example_scp = false`, inspect the OU plan, and only enable the sample SCP after reviewing its effect. SCPs set maximum permissions and do not grant permissions. Test guardrails in a disposable member account before attaching them to important OUs.

```bash
aws organizations list-roots
aws organizations list-organizational-units-for-parent --parent-id ROOT_ID
aws organizations list-policies-for-target --target-id OU_ID --filter SERVICE_CONTROL_POLICY
```
This does not configure Control Tower, account vending, IAM Identity Center, delegated administrators or centralized security services.
