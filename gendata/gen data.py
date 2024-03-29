import random

def_type = ['cash', 'bank_transfer', 'credit_card']
sub_type = ['A', 'A', 'A', 'B', 'B', 'C']
year_rand = [2020, 2021, 2021, 2021]
rider = ['UID00002','UID00003','UID00005']


def genuser(k):
    for i in range(min(9,k)):
        print("('UID1000{}', 'un{}', 'pass{}', 'email{}', 'fn{}', 'ln{}', '{}', 'customer'),".format(i+1, i+1, i+1, i+1, i+1, i+1, i+1))
    for i in range(9,k,1):
        print("('UID100{}', 'un{}', 'pass{}', 'email{}', 'fn{}', 'ln{}', '{}', 'customer'),".format(i+1, i+1, i+1, i+1, i+1, i+1, i+1))

def gencustomer(k):
    for i in range(min(9,k)):
        t_rand = random.choice(def_type)
        print("('UID1000{}', '{}'),".format(i+1, t_rand))
    for i in range(9,k,1):
        t_rand = random.choice(def_type)
        print("('UID100{}', '{}'),".format(i+1, t_rand))

def genride(k):
    for i in range(9):
        minute = random.randint(10,55)
        print("('RDE1000{}','UID1000{}','{}','completed',45,45,45,45,1,timestamp(\"2021-11-01 11:{}:00\"),timestamp(\"2021-11-01 11:{}:00\"),5,'comment'),".format(i+1,i+1,rider[i%3],minute,minute))
    for j in range(6):
        for i in range(10):
            date = j+10
            minute = random.randint(10,55)
            print("('RDE100{}','UID100{}','{}','completed',45,45,45,45,1,timestamp(\"2021-11-{} 11:{}:00\"),timestamp(\"2021-11-{} 11:{}:00\"),5,'comment'),".format(j*10+i+10,j*10+i+10,rider[i%3],date,minute,date,minute))
    

def gentransNovember(k):
    for i in range(9):
        amount = random.randint(50,150)
        minute = random.randint(10,55)
        print("('TRN1000{}', 'ride', timestamp(\"2021-11-01 12:{}:00\"), 'success', {}, 'cash'),".format(i+1,minute,amount))
    for j in range(6):
        for i in range(10):
            date = j+10
            amount = random.randint(50,150)
            minute = random.randint(10,55)
            print("('TRN100{}', 'ride', timestamp(\"2021-11-{} 12:{}:00\"), 'success', {}, 'cash'),".format(j*10+i+10,date, minute,amount))

def genridetransNovember(k):
    for i in range(9):
        print("('TRN1000{}','RDE1000{}'),".format(i+1,i+1))
    for j in range(6):
        for i in range(10):
            print("('TRN100{}','RDE100{}'),".format(j*10+i+10,j*10+i+10))


def gencustsub(k):
    for i in range(k):
        sun_rand = random.choice(sub_type)
        rand_d = random.randint(1,28)
        rand_m = random.randint(1, 12)
        rand_y = random.choice(year_rand)
        buy_st_date = "{}-{}-{}".format(rand_y, rand_m, rand_d)
        if (rand_m+1)%12 == 1:
            rand_y = rand_y+1
        if (rand_m+1)%12 != 0:
            rand_m = (rand_m+1)%12
        else:
            rand_m = 12
        end_st_date = "{}-{}-{}".format(rand_y, rand_m, rand_d)
        print("( '{}', 'id{}', date('{}'), date('{}'), date('{}'), 0 ),".format(sun_rand, i+1, buy_st_date, buy_st_date, end_st_date))


# To use, call the function with a parameter of number of users.
# For parameter k, id0 - id(k-1) will be generated.
# To insert into mysql, use INSERT TABLE(attr1, attr2, ....) value [Results from gen data.py]

# genuser(70)
# gencustomer(70)
# gentransNovember(70)
genridetransNovember(70)
# genride(70)