import random
secret = random.randint(1, 100)
while True:
    choix = int(input('Ton choix: '))
    if choix < secret: print('PLUS')
    elif choix > secret: print('MOINS')
    else: print('BRAVO'); break
