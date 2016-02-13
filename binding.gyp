{
	'targets': [{ 
		'target_name': 'node-tensorflow', 
		'sources': ['src/api.cc'],
		
		'libraries' : [],

		'include_dirs' : [ 

			# Third party must be included as root as well
      "lib/tensorflow/bazel-tensorflow",
      "lib/tensorflow/bazel-tensorflow/tensorflow",
			"lib/tensorflow/bazel-tensorflow/third_party/eigen3",
      "lib/tensorflow/bazel-tensorflow/external/eigen_archive/eigen-eigen-726c779797e8",
			"lib/tensorflow/third_party/gpus",
      "lib/tensorflow/bazel-tensorflow/external",
      "lib/tensorflow/bazel-tensorflow/external/eigen_archive",
      "lib/tensorflow",
      "lib/tensorflow/bazel-tensorflow/google/protobuf/src/",

			# Include NAN
			"<!(node -e \"require('nan')\")"
		],

		"conditions": [
			[ "OS==\"mac\"", {
				"xcode_settings": {
					"OTHER_CFLAGS": [
						"-mmacosx-version-min=10.7",
						"-std=c++",
						"-stdlib=libc++",
						"<!@(pkg-config --cflags protobuf)",
					],
					"OTHER_LDFLAGS": [
						'-stdlib=libc++',
					],
					"OTHER_CPLUSPLUSFLAGS": [
						'-std=c++11',
						'-stdlib=libc++',
						'-v'
					],
					"GCC_ENABLE_CPP_RTTI": "YES",
					"GCC_ENABLE_CPP_EXCEPTIONS": "YES",
					'MACOSX_DEPLOYMENT_TARGET': '10.9',
				},
			}]
		],
		'cflags': [
			"<!@(pkg-config --cflags protobuf)",
		],
		"cflags!": [
			"-fno-exceptions"
		],
		'cflags_cc!': [
			"-fno-rtti", "-fno-exceptions" 
		]
	}]
}
