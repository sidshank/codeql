def func():
    print("func()")

def return_func():
    return func

f1 = return_func() # $ pt,tt=return_func
f1() # $ pt,tt=func


def return_func_in_tuple():
    return (func, 42)

tup = return_func_in_tuple() # $ pt,tt=return_func_in_tuple

f2, _ = tup
f2() # $ pt=func MISSING: tt

f3 = tup[0]
f3() # $ tt,pt=func


def return_func_in_dict():
    return {'func': func, 'val': 42}

dct = return_func_in_dict() # $ pt,tt=return_func_in_dict

f4 = dct['func']
f4() # $ tt=func


def return_func_in_dict_update():
    d = {}
    d["func"] = func
    return d

dct2 = return_func_in_dict_update() # $ pt,tt=return_func_in_dict_update

f5 = dct2['func']
f5() # $ tt=func


def return_func_in_list():
    return [func, 42]

lst = return_func_in_list() # $ pt,tt=return_func_in_list

f6 = lst[0]
f6() # $ MISSING: pt,tt=func

if eval("False"): # don't run this, but fool analysis to still consider it (doesn't wok if you just to `if False:`)
    f7 = lst[1]
    f7()
