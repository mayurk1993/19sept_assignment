
def get_value(object, key):
    list_of_keys = key.split('/')

    val = object
    for i in list_of_keys:
        val = val[i]
    
    print(val)

object = {"a":{"b":{"c":"d"}}}
key = "a/b/c"

get_value(object, key)


