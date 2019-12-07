with open('04.input') as f:
    RangeVals = f.read()

RangeVals = RangeVals.split('-')
MinRange = RangeVals[0]
MaxRange = RangeVals[1]

MinRangeInt = int(MinRange)
MaxRangeInt = int(MaxRange)

def mustBeSixDigits(val):
    if len(val) == 6:
        return True
    return False

def sideBySideDigitsOccur(val):
    for x in range(len(val)):
        if x is not 0 and val[x - 1] == val[x]:
            return True
    return False

def hasIncreasingOrIdenticalNumbers(val):
    for x in range(len(val)):
        if x is not 0:
            if int(val[x - 1]) > int(val[x]):
                return False
    return True

def sideBySideDigitsAreIsolated(val):
    pairings = {}
    validPairings = {}

    for x in range(len(val)):
        if x is not 0 and val[x - 1] == val[x]:
            if val[x] in pairings:
                pairings[val[x]] = pairings[val[x]] + 1
            else:
                pairings[val[x]] = 1

    for i in pairings:
        if pairings[i] == 1:
            return True
    return False

passwordCounter = 0
for x in range(MinRangeInt, MaxRangeInt):
    x_str = str(x)
    if mustBeSixDigits(x_str) and sideBySideDigitsOccur(x_str) and hasIncreasingOrIdenticalNumbers(x_str) and sideBySideDigitsAreIsolated(x_str):
        passwordCounter += 1

print(passwordCounter)
