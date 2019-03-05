def maxPoints(self, points):
    fin = 0
    for i in range(len(points)):
        duplicates = 1
        m0 = dict()
        
        for j in range(i + 1, len(points)):
            if (points[i].x == points[j].x) and (points[i].y == points[j].y):
                duplicates += 1
            elif points[i].x == points[j].x:
                m0[sys.maxint] = m0.get(sys.maxint, 0) + 1
            else:
                slope = (points[i].y - points[j].y) / (points[i].x - points[j].x)
                m0[slope] = m0.get(slope, 0) + 1
        
       local_maxima = 0
       
       for k, v in m0.iteritems():
            local_maxima = max(local_maxima, v)
        local_maxima += duplicates

        fin = max(local_maxima, fin)
    return fin
