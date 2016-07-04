## Routes Extra Information

The following code does not work as it causes SyntaxError: Unexpected token <
'''
get '/*path' => 'forums#index' || get '/*path', to: 'forums#index'
'''

This error has been reported ember.debug.js:31686
