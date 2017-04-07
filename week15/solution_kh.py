def money(arr):
    a = {}
    a["💩"] = float("inf")
    a["🏆"] = float("-inf")
    a["🤑"]= float("-inf")

    for el in arr:
        if el < a["💩"]:
            a["💩"] = el
        elif el > a["🏆"]:
            a["🏆"] = el

        tmp = el - a["💩"]
        if tmp > a["🤑"]:
            a["🤑"] = tmp
    return a["🤑"]

