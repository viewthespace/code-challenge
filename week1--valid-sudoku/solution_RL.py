#!/usr/bin/env python




def validate (testnine):
    for n in range (1,10):
    #print t2.count(n)
        if testnine.count(n) >1:
            #print "fail"
            return(False)

    return(True)


def createarrays (fullinput):

    for n in range (0,9):
        vertical=[]
        horizontal = fullinput[n]
        for n2 in range (0,9):
            vertical.append(fullinput[n2][n])
        #print vertical
        if validate(vertical)==False:
            return (False)
        #print horizontal
        if validate(horizontal)==False:
            return(False)

    square=[]
    for y in (0,3,6):
        for x in (0,3,6):
            for h in range (0,3):
                for v in range (0,3):
                    #print h+x
                    square.append(fullinput[h+x][v+y])
            #print square
            if validate(square)==False:
                return(False)
            square=[]

    return(True)


def main():

    undefined=0



    validInputs = [\
    [\
    [undefined, undefined, undefined,    undefined, undefined, undefined,        1    ,     7     ,    4    ],\
    [undefined, undefined, undefined,    undefined, undefined, undefined,        2    ,     8     ,    5    ],\
    [undefined, undefined, undefined,    undefined, undefined, undefined,        3    ,     9     ,    6    ],\
    [undefined, undefined, undefined,        1    ,     2    ,     3    ,    undefined, undefined ,undefined],\
    [undefined, undefined, undefined,    undefined, undefined, undefined,    undefined, undefined ,undefined],\
    [undefined, undefined, undefined,    undefined, undefined, undefined,    undefined, undefined ,undefined],\
    [    1    ,     2    ,     4    ,        5    ,     6    ,     7    ,        8    ,     3     ,    9    ],\
    [undefined, undefined, undefined,    undefined, undefined, undefined,    undefined, undefined ,undefined],\
    [undefined, undefined, undefined,    undefined, undefined, undefined,    undefined, undefined ,undefined]\
    ],\
    [\
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],\
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],\
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],\
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],\
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],\
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],\
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],\
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],\
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined]\
    ],\
    [\
    [    1    ,     9    , undefined, undefined, undefined, undefined, undefined, undefined ,    8    ],\
    [    2    ,     8    , undefined, undefined,     9    , undefined, undefined, undefined ,undefined],\
    [    3    ,     7    , undefined, undefined, undefined, undefined, undefined, undefined ,undefined],\
    [    4    , undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],\
    [    5    , undefined, undefined, undefined,     1    , undefined, undefined, undefined ,undefined],\
    [    6    , undefined, undefined, undefined,     2    , undefined, undefined, undefined ,undefined],\
    [    7    ,     3    , undefined, undefined, undefined, undefined, undefined, undefined ,undefined],\
    [    8    ,     2    , undefined, undefined, undefined, undefined, undefined, undefined ,undefined],\
    [    9    ,     1    , undefined, undefined, undefined, undefined, undefined, undefined ,    4    ]\
    ]\
    ]

    invalidInputs = [\
    [\
    [undefined, undefined, undefined,    undefined, undefined, undefined,        1    ,     7     ,    9    ],\
    [undefined, undefined, undefined,    undefined, undefined, undefined,        2    ,     8     ,    5    ],\
    [undefined, undefined, undefined,    undefined, undefined, undefined,        3    ,     4     ,    6    ],\
    [undefined, undefined, undefined,        1    ,     2    ,     3    ,    undefined, undefined ,undefined],\
    [undefined, undefined, undefined,    undefined, undefined, undefined,    undefined, undefined ,undefined],\
    [undefined, undefined, undefined,    undefined, undefined, undefined,    undefined, undefined ,undefined],\
    [    1    ,     2    ,     4    ,        5    ,     6    ,     7    ,        8    ,     3     ,    9    ],\
    [undefined, undefined, undefined,    undefined, undefined, undefined,    undefined, undefined ,undefined],\
    [undefined, undefined, undefined,    undefined, undefined, undefined,    undefined, undefined ,undefined]\
    ],\
    [\
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],\
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],\
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],\
    [    1    , undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],\
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],\
    [undefined, undefined,     1    , undefined, undefined, undefined, undefined, undefined ,undefined],\
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],\
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],\
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined]\
    ],\
    [\
    [    1    ,     9    , undefined, undefined, undefined, undefined, undefined, undefined ,    8    ],\
    [    2    ,     8    , undefined, undefined,     8    , undefined, undefined, undefined ,undefined],\
    [    3    ,     7    , undefined, undefined, undefined, undefined, undefined, undefined ,undefined],\
    [    4    , undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],\
    [    5    , undefined, undefined, undefined,     1    , undefined, undefined, undefined ,undefined],\
    [    6    , undefined, undefined, undefined,     2    , undefined, undefined, undefined ,undefined],\
    [    7    ,     3    , undefined, undefined, undefined, undefined, undefined, undefined ,undefined],\
    [    8    ,     2    , undefined, undefined, undefined, undefined, undefined, undefined ,undefined],\
    [    9    ,     1    , undefined, undefined, undefined, undefined, undefined, undefined ,    4    ]\
    ]\
    ]

    counter=0
    for n in validInputs:
        if createarrays(n) == False:
            print "Failed valid input test case #",counter
        counter+=1

    counter=0
    for n in invalidInputs:
        if createarrays(n) == False:
            print "Failed valid input test case #",counter
        counter+=1



if __name__ == '__main__':
    main()