{
    'targets': [{ 
        'target_name': 'node-tensorflow', 
        'sources': ['src/api.cc'],
	    "include_dirs" : [ 
            "/usr/local/lib/tensorflow", # Use pkg-config later on
            "/usr/local/lib/tensorflow/google/protobuf/src", # Use pkg-config later on
            "<!(node -e \"require('nan')\")"
        ],
        "conditions": [
            [ "OS==\"mac\"", {
                "xcode_settings": {
                "OTHER_CFLAGS": [
                    "-mmacosx-version-min=10.7",
                    "-std=c++11",
                    "-stdlib=libc++",
                    "/usr/local/lib/tensorflow", # Use pkg-config later on
                    "/usr/local/lib/tensorflow/google/protobuf/src" # Use pkg-config later on
                  ],
                "GCC_ENABLE_CPP_RTTI": "YES",
                "GCC_ENABLE_CPP_EXCEPTIONS": "YES"
              }
            }]
        ],
        "cflags!" : [ "-fno-exceptions"]
    }] 
}
