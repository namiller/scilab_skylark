def _impl(ctx):
  runfiles = ctx.runfiles(files=[ctx.file.src])
  ctx.actions.write(
      output=ctx.outputs.executable,
      content="#!/bin/bash\n%s -e \"exec('%s')\"%s" % (ctx.attr.scilab,
                                                       ctx.file.src.path,
                                                       " -nb" if ctx.attr.quiet_start else ""),
      is_executable=True,
  )
  return [DefaultInfo(runfiles=runfiles)]

scilab_binary = rule(
    implementation = _impl,
    executable = True,
    attrs = {
        "quiet_start": attr.bool(default = True),
        "src": attr.label(mandatory=True, allow_single_file=True),
        "scilab": attr.string(default = "scilab-cli"),
    },
)
