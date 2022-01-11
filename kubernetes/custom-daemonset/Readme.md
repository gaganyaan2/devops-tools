## Custom-daemonset

### Why?
When we need to add some extra functionally to daemonset based on which worker node it’s running on.

### How?
1. add status.hostIP env variable
2. Write shellscript based on env variable
3. add shellscript as command for container