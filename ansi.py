from typing import Union, Optional
import os


def style(
        bold: Optional[bool] = None,
        italic: Optional[bool] = None,
        underline: Optional[bool] = None,
        blink: Optional[bool] = None,
        strike: Optional[bool] = None,
        fg: Union[int, tuple[int], None] = None,
        bg: Union[int, tuple[int], None] = None
):
    """
    :param bold: None (unchanged), False (normal weight) or True (bold)
    :param italic: None (unchanged), False (not italic) or True (italic)
    :param underline: None (unchanged), False (not underlined) or True (underlined)
    :param blink: None (unchanged), False (static) or True (blinking)
    :param strike: None (unchanged), False (not striked) or True (striked)
    :param fg: None (unchanged), int from 0-255 or tuple (red, green, blue)
    :param bg: None (unchanged), int from 0-255 or tuple (red, green, blue)
    :return: A string which can be used for styling text in the terminal with given aspects or a reset of all arguments
     if no parameter is specified
    """
    out = ''
    if bold is not None:
        out += '1;' if bold else '22;'
    if italic is not None:
        out += '3;' if italic else '23;'
    if underline is not None:
        out += '4;' if underline else '24;'
    if blink is not None:
        out += '5;' if blink else '25;'
    if strike is not None:
        out += '9;' if strike else '29;'
    if fg is not None:
        if isinstance(fg, int):
            out += f'38;5;{fg};'
        else:
            out += f'38;2;{fg[0]};{fg[1]};{fg[2]};'
    if bg is not None:
        if isinstance(bg, int):
            out += f'48;5;{bg};'
        else:
            out += f'48;2;{bg[0]};{bg[1]};{bg[2]};'
    return f'\u001b[{out[:-1]}m' if out else '\u001b[0m'


class Curser:
    @staticmethod
    def save_pos(): print('\u001b[s', end='')

    @staticmethod
    def restore_pos(): print('\u001b[u', end='')

    @staticmethod
    def up(steps: int = 1): print(f'\u001b[{steps}A', end='')

    @staticmethod
    def down(steps: int = 1): print(f'\u001b[{steps}B', end='')

    @staticmethod
    def left(steps: int = 1): print(f'\u001b[{steps}D', end='')

    @staticmethod
    def right(steps: int = 1): print(f'\u001b[{steps}C', end='')

    @staticmethod
    def prev_line(lines: int = 1): print(f'\u001b[{lines}F', end='')

    @staticmethod
    def next_line(lines: int = 1): print(f'\u001b[{lines}E', end='')

    @staticmethod
    def set_col(column: int = 1): print(f'\u001b[{column}G', end='')

    @staticmethod
    def set_pos(line: int = 1, column: int = 1): print(f'\u001b[{line};{column};H', end='')

    @staticmethod
    def hide(): print('\u001b[?25l', end='')

    @staticmethod
    def show(): print('\u001b[?25h', end='')

    @staticmethod
    def get_lines() -> int: return int(os.popen('tput lines').read())

    @staticmethod
    def get_cols() -> int: return int(os.popen('tput cols').read())
