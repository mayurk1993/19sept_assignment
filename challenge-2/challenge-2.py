# python program to parse json

import json
import os


os.chdir('c:/Users/mayur/OneDrive/Documents/Study Material/Python/Interview/challenge-2/')

f = open('response.json', 'r')
result = f.read()
f.close()



my_dict = json.loads(result)

# Take key input from user

key = input("Enter metadata key")
val = my_dict[key]


print(val)




