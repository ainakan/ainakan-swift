subdir('Ainakan_Private')

sources = [
  'ApplicationDetails.swift',
  'AsyncEventSource.swift',
  'AsyncOperation.swift',
  'AuthenticationService.swift',
  'Bus.swift',
  'ChildDetails.swift',
  'CrashDetails.swift',
  'CustomAuthenticationService.swift',
  'Device.swift',
  'DeviceListModel.swift',
  'DeviceManager.swift',
  'EndpointParameters.swift',
  'Error.swift',
  'Icon+AppKit.swift',
  'Icon+CGImage.swift',
  'Icon+SwiftUI.swift',
  'Icon+UIKit.swift',
  'Icon.swift',
  'Marshal.swift',
  'PortalMembership.swift',
  'PortalService.swift',
  'ProcessDetails.swift',
  'Relay.swift',
  'RpcFunction.swift',
  'Runtime.swift',
  'Script.swift',
  'Session.swift',
  'SignalConnection.swift',
  'SpawnDetails.swift',
]

subdir('GLib')
sources += glib_sources

subdir('JSONGLib')
sources += json_glib_sources

extra_link_args = []
extra_link_depends = []
if host_os_family == 'darwin'
  extra_link_args += ['-Xlinker', '-exported_symbol', '-Xlinker', '_$*']
elif cc.get_argument_syntax() != 'msvc'
  symscript = 'Ainakan.version'
  extra_link_args += ['-Xlinker', '--version-script', '-Xlinker', meson.current_source_dir() / symscript]
  extra_link_depends += symscript
endif

ainakan_incdirs = include_directories('.')

ainakan_lib = shared_library('Ainakan', sources,
  include_directories: ainakan_incdirs,
  swift_args: [
    '-swift-version', '5',
    '-enable-library-evolution',
    '-emit-module-interface',
  ],
  link_args: extra_link_args,
  link_depends: extra_link_depends,
  dependencies: ainakan_private_dep,
  install: host_os_family != 'darwin',
)

ainakan_dep = declare_dependency(
  include_directories: ainakan_incdirs,
  link_with: ainakan_lib,
)

meson.override_dependency('ainakan-swift', ainakan_dep)

if host_os_family == 'darwin'
  custom_target('ainakan-framework',
    input: [
      ainakan_lib,
      'Ainakan.h',
      'Info.plist',
    ],
    output: 'Ainakan.framework',
    command: [
      python,
      files('generate-framework.py'),
      host_triplet,
      '@OUTPUT@',
      '@INPUT@',
    ],
    install: true,
    install_dir: get_option('prefix') / 'Frameworks',
  )
endif
