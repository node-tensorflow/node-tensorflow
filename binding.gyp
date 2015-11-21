{
    'targets': [{ 
        'target_name': 'node-tensorflow', 
        'sources': ['./src/node-tensorflow.cc'],
	    "include_dirs" : [ 
            "<!(node -e \"require('nan')\")"
        ]
    }] 
}
