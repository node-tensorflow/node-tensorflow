{
	'targets': [{ 
		'target_name': 'node-tensorflow', 
		'sources': ['src/api.cc'],
		"include_dirs" : [ 
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
					"-std=c++11",
					"-stdlib=libc++"
				  ],
				"GCC_ENABLE_CPP_RTTI": "YES",
				"GCC_ENABLE_CPP_EXCEPTIONS": "YES"
			  }
			}]
		],
		"cflags!" : [ "-fno-exceptions"]
	}]
}
