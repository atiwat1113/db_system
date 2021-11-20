import random

def_type = ['cash', 'bank_transfer', 'credit_card']
sub_type = ['A', 'A', 'A', 'B', 'B', 'C']
year_rand = [2020, 2021, 2021, 2021]


def genuser(k):
    for i in range(k):
        print("('id{}', 'un{}', 'pass{}', 'email{}', 'fn{}', 'ln{}', '{}', 'customer'),".format(i+1, i+1, i+1, i+1, i+1, i+1, i+1))

def gencustomer(k):
    for i in range(k):
        t_rand = random.choice(def_type)
        print("('id{}', '{}'),".format(i+1, t_rand))

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
gencustsub(70)