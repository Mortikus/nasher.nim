from strutils import join
import utils/[cli, options]

const
  helpList* = """
  Usage:
    nasher list [options]

  Description:
    For each target, lists the name, description, source files, and final
    filename of all build targets. These names can be passed to the compile or
    pack commands.
  """

proc list*(opts: Options, pkg: PackageRef) =
  if pkg.targets.len > 0:
    var hasRun = false
    for target in pkg.targets:
      if hasRun:
        stdout.write("\n")
      display("Target:", target.name, priority = HighPriority)
      display("Description:", target.description)
      display("File:", target.file)
      display("Includes:", target.includes.join("\n"))
      display("Excludes:", target.excludes.join("\n"))
      hasRun = true
  else:
    fatal("No targets found. Please check your nasher.cfg.")
