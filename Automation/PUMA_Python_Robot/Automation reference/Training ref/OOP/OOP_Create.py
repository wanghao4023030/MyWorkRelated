# -*- coding : utf-8 -*-
'''
class Dog():
    name = "WangCai"
    age = 2
    breed = "Chinese countryside"

    def __init__(self):
        print("This is a dog")
        print("Name is: " + self.name)
        print("Age is: " + str(self.age))
        print("Breed is: " + self.breed)

    def run(self):
        print("This dog is running.")

    def sit(self):
        print(self.name + " sit down.")


#mydog = Dog()
'''


class Dog():

    def __init__(self):
        self.name = "Lai Fu"
        self.age = 4
        self.breed = "Country dog"

    def run(self):
        print(self.name +" is running.")

    def sit(self):
        print(self.name + " sit down.")

    def bark(self, flag):
        if flag == True:
            print("The dog " + self.name + " is barking." )
        else:
            # do nothing....
            print("The dog " + self.name + " is NOT barking.")


class Policedog(Dog):
    def __init__(self):
        super().__init__()
        self.ID = "9527"
        self.section = "803"

    def patrol(self):
        print("The police dog " + self.ID +" is patroling on the rouds")

police_dog = Policedog()
police_dog.run()
print(police_dog.name)
police_dog.patrol()
print(police_dog.section)

'''
output:
Lai Fu is running.
Lai Fu
The police dog 9527is patroling on the rouds
803
'''

