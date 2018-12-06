#! /usr/bin/python3

from collections import OrderedDict

ALUFN = OrderedDict(sorted({
    '+': 'b000000',
    '-': 'b000001',
    '*': 'b000010',
    '^': 'b010110',
    '&': 'b011000',
    '|': 'b011110',
    '<<': 'b100000',
    '>>': 'b100001',
    '==': 'b110011',
    '<': 'b110101',
    '<=': 'b110111',
    '!=': 'b111011',
    '>=': 'b111101',
    '>': 'b111111',
}.items(), key=lambda pair:-len(pair[0])))


MEMORY = [
    'game_running',
    'tick_period',
    'conditional',
    'doodle_pos',
    'doodle_dir',
    'is_le',
    'is_ge',
    'terrain_gen_counter',
    'cooldown',
    'input_correct',
    'qn2',
    'qn1',
    'qn0',
    'terrain3l',
    'terrain3r',
    'terrain2l',
    'terrain2r',
    'terrain1l',
    'terrain1r',
    'terrain0l',
    'terrain0r',
    'doodle5',
    'doodle4',
    'doodle3',
    'doodle2',
    'doodle1',
    'doodle0',
    'score',
    'reg0',
    'reg1',
    'reg2',
    'prng0',
    'prng1',
    'prng2',
    'input',
    'ZERO',
    'ONE',
    'THREE',
    'NINE',
    'FIFTEEN',
    'HUNDRED',
    'SHIFT_MASK',
    'PRNG_MASK',
    'COLLISION_MASK',
    'DOODLE_SPRITE5',
    'DOODLE_SPRITE4',
    'DOODLE_SPRITE3',
    'DOODLE_SPRITE2',
    'DOODLE_SPRITE1',
    'DOODLE_SPRITE0',
    'MAX_HEIGHT',
    'OBSTACLE_WIDTH',
    'OBSTACLE_SEPARATION',
    'MAX_COOLDOWN',
]


def resolve_memory(name, line_index):
    try:
        return 'b' + format(int(bin(MEMORY.index(name))[2:]), '06')
    except ValueError:
        raise Exception(f"line {line_index}: no memory location named '{name}'")

def parse_expr(expr, line_index):
    for operator in ALUFN.keys():
        if operator in expr:
            operator_pos = expr.index(operator)
            left = expr[:operator_pos].strip()
            right = expr[operator_pos + len(operator):].strip()
            return ALUFN[operator], resolve_memory(left, line_index), resolve_memory(right, line_index)
    return ALUFN['+'], resolve_memory(expr.strip(), line_index), resolve_memory('ZERO', line_index)

def parse_line(line, line_index):
    # remove comments
    if '#' in line:
        line = line[:line.index('#')]
    # parse instruction line
    if '=' in line:
        eq_pos = line.index('=')
        destination = line[:eq_pos].strip()
        expr = line[eq_pos+1:]
        return parse_expr(expr, line_index) + (resolve_memory(destination, line_index),)
    else:
        return None

def make_rom(lines):
    rom_lines = []
    for i in range(len(lines)):
        line = lines[i]
        parsed = parse_line(line, i+1)
        if parsed != None:
            rom_lines.append(
                '{' + ', '.join(parsed) + '}'
            )
    return '{\n' + ',\n'.join(reversed(rom_lines)) + '\n};'


if __name__ == '__main__':
    from sys import argv
    with open(argv[1]) as file:
        print(make_rom(file.readlines()))

