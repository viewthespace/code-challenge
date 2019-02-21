# TODO: make this better/faster
[3, 5, 6, 3, 2, 2, 8, 6, 5, 5, 5].group_by{|n| n}.find{|g| g[1].size == 1}.first
