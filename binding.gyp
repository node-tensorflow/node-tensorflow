{
	'targets': [{ 
		'target_name': 'node-tensorflow', 
		'sources': ['src/api.cc'],
		
		'libraries' : [ 
			"<!@(pkg-config --libs protobuf)",
			"<!@(find $(pwd)/src/lib -iname \*.o)",
		],

		'include_dirs' : [ 
			# All c++ dependencies goes here
			"src/includes",

			# Third party must be included as root as well
			"src/includes/third_party/eigen3",
			"src/includes/third_party/gpus",

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
