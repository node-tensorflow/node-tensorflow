{
	'targets': [{ 
		'target_name': 'node-tensorflow', 
		'sources': ['./src/node-tensorflow.cc'],
		'defines': [
			'GOOGLE_PROTOBUF_NO_THREADLOCAL'
		],

		'conditions': [
			[ 'OS=="mac"',
				{
					'cflags_cc!': ['-fno-rtti'],
					'cflags_cc+': [
						'-frtti',
						'-stdlib=libstdc++'
					],
					'xcode_settings': {
						'GCC_ENABLE_CPP_EXCEPTIONS': 'YES',
						'GCC_ENABLE_CPP_RTTI': '-frtti'
					}
				}
			],
		],

		'include_dirs' : [ 
			"<!(node -e \"require('nan')\")",
			"util/tensorflow/bazel-out/local_darwin-fastbuild/genfiles",
			"util/tensorflow/google/protobuf/src",
			"util/tensorflow",
		]
	}] 
}
