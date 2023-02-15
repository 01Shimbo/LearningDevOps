list1 = [1, 20, 9, 19, 14, 5, 25, 23, 18, 21, 8, 8, 13, 13, 12]
andswer = 0
for i in range(len(list1)):
    if i != 0 and i != len(list1) - 1: 
        number = list1[i]
        if number <= (list1[i + 1] + list1[i - 1]):
            math = (list1[i + 1] + list1[i - 1])
            andswer += 1
print (andswer)