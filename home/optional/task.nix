# Pending review
{pkgs, ...}: {
  programs.taskwarrior = {
    enable = false;
    package = pkgs.taskwarrior3;
    config = {
      weekstart = "Monday";

      # Remove irrational urgency coefficients
      urgency.annotations.coefficient = 0;
      urgency.blocking.coefficient = 0;
      urgency.blocked.coefficient = 0;
      urgency.project.coefficient = 0;
      urgency.tags.coefficient = 0;

      # Don't ask when deleting recurrent tasks
      recurrence.confirmation = false;

      # Custom filter
      report.next.filter = "status:pending +UNBLOCKED limit:20";
      report.next.columns = ["id" "start.age" "depends.indicator" "priority" "project" "tags" "scheduled.countdown" "due.remaining" "until.remaining" "description.count"];
      report.next.labels = ["ID" "Active" "D" "P" "Project" "Tags" "Sch" "Due" "Until" "Description"];
      report.next.sort = ["start-" "due+" "priority-" "project+" "urgency-"];
    };
  };
}
