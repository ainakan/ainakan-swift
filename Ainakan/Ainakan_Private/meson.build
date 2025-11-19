ainakan_private_depends = []
if ainakan_core_dep.type_name() == 'internal'
  # XXX: Cannot get our custom_target() to depend on ainakan_core_dep itself
  ainakan_private_depends += subproject('ainakan-core').get_variable('core_api')
endif

ainakan_private_modulemap = custom_target('modulemap',
  output: 'module.modulemap',
  command: [
    python,
    files('generate-modulemap.py'),
    '@OUTPUT@',
    ainakan_core_dep.get_variable('ainakan_includedir') / 'ainakan-core.h',
  ],
  depends: ainakan_private_depends,
)

ainakan_private_dep = declare_dependency(
  sources: ainakan_private_modulemap,
  dependencies: ainakan_core_dep,
)
