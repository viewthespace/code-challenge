### Week 1 Coding Challenge - Valid Sudoku

Given a partially filled matrix (2d array), check if valid (http://sudoku.com.au/TheRules.aspx)

#### Example Test Cases

``` Javascript
//run with: node test.js

var assert = require('assert');

var solution = function(board) {
  throw Error('Implement me');
};

var validInputs = [

  [
    [undefined, undefined, undefined,    undefined, undefined, undefined,        1    ,     7     ,    4    ],
    [undefined, undefined, undefined,    undefined, undefined, undefined,        2    ,     8     ,    5    ],
    [undefined, undefined, undefined,    undefined, undefined, undefined,        3    ,     9     ,    6    ],

    [undefined, undefined, undefined,        1    ,     2    ,     3    ,    undefined, undefined ,undefined],
    [undefined, undefined, undefined,    undefined, undefined, undefined,    undefined, undefined ,undefined],
    [undefined, undefined, undefined,    undefined, undefined, undefined,    undefined, undefined ,undefined],

    [    1    ,     2    ,     4    ,        5    ,     6    ,     7    ,        8    ,     3     ,    9    ],
    [undefined, undefined, undefined,    undefined, undefined, undefined,    undefined, undefined ,undefined],
    [undefined, undefined, undefined,    undefined, undefined, undefined,    undefined, undefined ,undefined]
  ],

  [
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined]
  ],

  [
    [    1    ,     9    , undefined, undefined, undefined, undefined, undefined, undefined ,    8    ],
    [    2    ,     8    , undefined, undefined,     9    , undefined, undefined, undefined ,undefined],
    [    3    ,     7    , undefined, undefined, undefined, undefined, undefined, undefined ,undefined],
    [    4    , undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],
    [    5    , undefined, undefined, undefined,     1    , undefined, undefined, undefined ,undefined],
    [    6    , undefined, undefined, undefined,     2    , undefined, undefined, undefined ,undefined],
    [    7    ,     3    , undefined, undefined, undefined, undefined, undefined, undefined ,undefined],
    [    8    ,     2    , undefined, undefined, undefined, undefined, undefined, undefined ,undefined],
    [    9    ,     1    , undefined, undefined, undefined, undefined, undefined, undefined ,    4    ]
  ]

]

var invalidInputs = [

  [
    [undefined, undefined, undefined,    undefined, undefined, undefined,        1    ,     7     ,    9    ],
    [undefined, undefined, undefined,    undefined, undefined, undefined,        2    ,     8     ,    5    ],
    [undefined, undefined, undefined,    undefined, undefined, undefined,        3    ,     4     ,    6    ],

    [undefined, undefined, undefined,        1    ,     2    ,     3    ,    undefined, undefined ,undefined],
    [undefined, undefined, undefined,    undefined, undefined, undefined,    undefined, undefined ,undefined],
    [undefined, undefined, undefined,    undefined, undefined, undefined,    undefined, undefined ,undefined],

    [    1    ,     2    ,     4    ,        5    ,     6    ,     7    ,        8    ,     3     ,    9    ],
    [undefined, undefined, undefined,    undefined, undefined, undefined,    undefined, undefined ,undefined],
    [undefined, undefined, undefined,    undefined, undefined, undefined,    undefined, undefined ,undefined]
  ],

  [
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],
    [    1    , undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],
    [undefined, undefined,     1    , undefined, undefined, undefined, undefined, undefined ,undefined],
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],
    [undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined]
  ],

  [
    [    1    ,     9    , undefined, undefined, undefined, undefined, undefined, undefined ,    8    ],
    [    2    ,     8    , undefined, undefined,     8    , undefined, undefined, undefined ,undefined],
    [    3    ,     7    , undefined, undefined, undefined, undefined, undefined, undefined ,undefined],
    [    4    , undefined, undefined, undefined, undefined, undefined, undefined, undefined ,undefined],
    [    5    , undefined, undefined, undefined,     1    , undefined, undefined, undefined ,undefined],
    [    6    , undefined, undefined, undefined,     2    , undefined, undefined, undefined ,undefined],
    [    7    ,     3    , undefined, undefined, undefined, undefined, undefined, undefined ,undefined],
    [    8    ,     2    , undefined, undefined, undefined, undefined, undefined, undefined ,undefined],
    [    9    ,     1    , undefined, undefined, undefined, undefined, undefined, undefined ,    4    ]
  ]

]

for(var i = 0; i < validInputs.length; i++){
  var input = validInputs[i];
  assert(solution(input), 'Failed valid input test case #' + i)
}

for(var i = 0; i < invalidInputs.length; i++){
  var input = invalidInputs[i];
  assert(!solution(input), 'Failed invalid test case #' + i)
}
```
