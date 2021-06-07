import time


def show_spinner(spinner: list[str], iterations: int = 10, speed: float = .1):
    print('\u001b[?25l', end='')
    for i in range(iterations):
        for frame in spinner:
            print(f'\r{frame}', end='')
            time.sleep(speed)
    print('\u001b[?25h')


show_spinner([
    '⠁⠀',
    '⠐⠀',
    '⠀⠄',
    '⠀⢀',
    '⠀⠄',
    '⠐⠀',
])
show_spinner([
    '⠁⠀',
    '⠉⠀',
    '⠉⠁',
    '⠉⠉',
    '⠉⠙',
    '⠉⠹',
    '⠉⠽',
    '⠉⠽',
    '⠨⠽',
    '⢠⠽',
    '⢠⠼',
    '⢠⠴',
    '⢠⠤',
    '⢠⠄',
    '⢠⠀',
    '⢀⠀',
    '⠀⠀',
    '⠀⠀',
    '⠀⠀',
], 5)
