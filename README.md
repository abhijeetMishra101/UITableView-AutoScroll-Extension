# UITableView+AutoScroll
A UITableView extension which automatically scrolls a UITableView to show a cell clicked by user in-case the selected cell's complete visible area is either below or above the UITableView's visible area.

## Motivation
Had trouble in scenarios when a user selects a UITableViewCell is partly visible? Say you have a logic to check/uncheck or expand/collapse a cell upon click but the cell clicked by user is partly either below the visible area or above the visible area. 
Wouldn't it be great to automatically scroll the selected cell to visible area, to show the end user complete info about the cell he/she is interested in? 
I mean anyways the user is going to scroll such a cell to view the entire content, so shouldn't autoscrolling it to visible area be an ideal UX experience?

![](problem.gif)

:unamused::tired_face::expressionless:

## Solution
Here is a piece of code(an extension for UITableView) which can make it. Just call the UITableView's func "makeSelectedCellVisible()" and pass the selected cells indexpath as a parameter. And that's it! Just call this code wherever your UITableView's selection logic lies (either UITableViewDelegate's didSelectRow fun, an IBAction or any custom target function code you have).

![](solution.gif)

That's all to make it work! :trollface: :see_no_evil:
